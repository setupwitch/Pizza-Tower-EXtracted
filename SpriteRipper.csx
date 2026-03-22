using System;
using System.IO;
using System.Text.Json;
using UndertaleModLib.Util;
using System.Runtime.CompilerServices;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Collections.Concurrent;

public class ConfigData
{
    public bool OpenFileBrowser { get; set; } = true;
    public string ProjectPath { get; set; } = string.Empty;
    public bool CopyIncludedFiles { get; set; } = false;
    public List<string> SpriteIgnore { get; set; } = new();
}

public class TextureToRip
{
    public UndertaleTexturePageItem PageItem { get; set; }
    public UndertaleEmbeddedTexture Page => PageItem.TexturePage;
    public List<string> FileExportLocations { get; set; }
    
    public TextureToRip(UndertaleTexturePageItem pageItem, string[] fileExportLocations) =>
        (PageItem, FileExportLocations) = (pageItem, fileExportLocations.ToList());
    
    public TextureToRip(UndertaleTexturePageItem pageItem, string fileExportLocation)
    {
        PageItem = pageItem;
        FileExportLocations = new();
        FileExportLocations.Add(fileExportLocation);
    }
}


EnsureDataLoaded();

string scriptDirectory = Path.GetDirectoryName(FilePath) + "\\";

// Work-around helper method to get the source file location.
private static string GetSourceFile([CallerFilePath] string file = "") => file;
string executionPath = Path.GetDirectoryName(Path.GetFullPath(GetSourceFile()));

string? projectDirectory = null;
string? yypPath = null;
ConcurrentDictionary<string, ConcurrentBag<TextureToRip>> texturesToRip = new();
int textureCount = 0;
ConcurrentBag<string> errors = new();

// universal options
JsonSerializerOptions jsonOptions = new()
{ 
    AllowTrailingCommas = true,
    Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping,
    WriteIndented = true,
    ReadCommentHandling = JsonCommentHandling.Skip,
};

// get config
string configPath = Path.Combine(executionPath, "RipperConfig.json");
ConfigData? config = null;

if (File.Exists(configPath))
{
    string fileData = File.ReadAllText(configPath);
    if (!string.IsNullOrEmpty(fileData))
    {
        config = JsonSerializer.Deserialize<ConfigData>(fileData, jsonOptions);
    }

}

if (config is null)
{
    config = new ConfigData(); // default
}

if (!OperatingSystem.IsWindows())
{
    config.OpenFileBrowser = false;
}

void AcceptProject(string path)
{
    projectDirectory = Path.GetDirectoryName(path);
    yypPath = path;
}

while (projectDirectory is null && config.OpenFileBrowser)
{
    using (System.Windows.Forms.OpenFileDialog ofd = new()
    {
        InitialDirectory = executionPath,
        Filter = "YoYo Project files (*.yyp)|*.yyp|All files (*.*)|*.*",
        FilterIndex = 1,
        RestoreDirectory = true
    })

    if (ofd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
    {
        AcceptProject(ofd.FileName);
    }
}

if (projectDirectory is null && !string.IsNullOrEmpty(config.ProjectPath))
{
    // fallback to using that relative path
    string fullPath = Path.Combine(executionPath, config.ProjectPath);

    if (File.Exists(fullPath) && fullPath.EndsWith(".yyp"))
    {
        AcceptProject(fullPath);
    }
}

// if still null
if (projectDirectory is null)
{
    throw new FileNotFoundException("Could not find project!");
}

GMProject project = JsonSerializer.Deserialize<GMProject>(File.ReadAllText(yypPath), jsonOptions);

// obtain all of the necessary files to put into datafiles.
if (config.CopyIncludedFiles)
{
    foreach (var file in project.IncludedFiles)
    {
        string sourceFilePath = Path.Combine(scriptDirectory, file.filePath.Replace("datafiles", "").TrimStart('\\', '/'), file.name);
        string destFilePath = Path.Combine(projectDirectory, file.filePath, file.name);

        // Ensure destination directory exists
        Directory.CreateDirectory(Path.GetDirectoryName(destFilePath)!);

        // Copy file
        if (File.Exists(sourceFilePath))
        {
            File.Copy(sourceFilePath, destFilePath, true);
        }
        else
        {
            Console.WriteLine($"Missing file: {sourceFilePath}");
        }
    }
}

// time for the main part.
string tilesetPath = Path.Combine(projectDirectory, "tilesets");
HashSet<string> tilesetSprites = new();

foreach (var tsDir in Directory.GetDirectories(tilesetPath))
{
    string tilesetName = Path.GetFileName(tsDir); // use GetFileName instead of GetDirectoryName
    string yyPath = Path.Combine(tsDir, $"{tilesetName}.yy");

    if (!File.Exists(yyPath))
    {
        errors.Add($"Cannot find YY file for tileset asset '{tilesetName}' at location '{yyPath}'");
        continue;
    }

    string json = File.ReadAllText(yyPath);
    var tileset = JsonSerializer.Deserialize<GMTileSet>(json, jsonOptions);
    if (tileset is not null && tileset.spriteId is not null)
    {
        tilesetSprites.Add(tileset.spriteId.name);
    }

}


string spritePath = Path.Combine(projectDirectory, "sprites");

string[] sprDirs = Directory.GetDirectories(spritePath);

SetProgressBar(null, "Sprite textures to obtain data for", 0, sprDirs.Length - tilesetSprites.Count);
StartProgressBarUpdater();

SetUMTConsoleText("Running...");

var parallelOptions = new ParallelOptions { MaxDegreeOfParallelism = 4 }; // Limit to 2 threads
await Task.Run(() => Parallel.ForEach(sprDirs, parallelOptions, path =>
{
    ProcessSprite(path);
}));


void ProcessSprite(string sprDir)
{
    string spriteName = Path.GetFileName(sprDir);

    if (config.SpriteIgnore.Contains(spriteName) || tilesetSprites.Contains(spriteName))
    {
        IncrementProgressParallel();
        return;
    }

    string yyPath = Path.Combine(sprDir, $"{spriteName}.yy");

    if (!File.Exists(yyPath))
    {
        errors.Add($"Cannot find YY file for sprite asset '{spriteName}' at location '{yyPath}'");
        IncrementProgressParallel();
        return;
    }


    string json = File.ReadAllText(yyPath);
    var sprite = JsonSerializer.Deserialize<GMSprite>(json, jsonOptions);

    int index = Data.Sprites
    .Select((sprite, idx) => new { sprite, idx })
    .Where(x => x.sprite.Name.Content == spriteName)
    .Select(x => x.idx)
    .DefaultIfEmpty(-1)
    .First();

    if (index == -1)
    {
        errors.Add($"Cannot find sprite asset '{spriteName}' in the games data file.");
        return;
    }

    UndertaleSprite sprData = Data.Sprites[index];

    if (sprData.SSpriteType != UndertaleSprite.SpriteType.Normal)
    {
        errors.Add($"Sprite asset '{spriteName}' is not a raster image and therefore cannot be easily ripped.");
        return;
    }

    string layerDir = Path.Combine(sprDir, "layers");
    Directory.CreateDirectory(layerDir);
    foreach (GMSprite.GMImageLayer layer in sprite.layers)
    {
        for (int i = 0; i < sprite.frames.Count; i++)
        {
            GMSprite.GMSpriteFrame frame = sprite.frames[i];
            frame.Texture = sprData.Textures[i].Texture;
            string frameDir = Path.Combine(layerDir, frame.name);
            Directory.CreateDirectory(frameDir);

            string pngPath = Path.Combine(frameDir, layer.name) + ".png";
            
            var bag = texturesToRip.GetOrAdd(frame.Texture.TexturePage.Name.Content, _ => new ConcurrentBag<TextureToRip>());
            
            bag.Add(new TextureToRip(frame.Texture, [pngPath, Path.Combine(sprDir, frame.name) + ".png"]));
            Interlocked.Increment(ref textureCount);
        }
    }
    IncrementProgressParallel();
}

await StopProgressBarUpdater();
HideProgressBar();

public void ExecuteTextureBatch(ConcurrentDictionary<string, ConcurrentBag<TextureToRip>> texturesToRip)
{
    int totalCores = Environment.ProcessorCount;
    int outerLimit = Math.Max(1, totalCores / 4); // save some memory
    Parallel.ForEach(texturesToRip, new ParallelOptions { MaxDegreeOfParallelism = outerLimit }, kvp =>
    {
        // separate worker for each page to bound memory usage
        using (TextureWorker localWorker = new TextureWorker())
        {
            foreach (var textureToRip in kvp.Value)
            {
                // the main path to export to
                string mainPath = textureToRip.FileExportLocations[0];
                
                localWorker.ExportAsPNG(textureToRip.PageItem, mainPath, null, true);

                // copy it to any extra
                for (int i = 1; i < textureToRip.FileExportLocations.Count; i++)
                {
                    File.Copy(mainPath, textureToRip.FileExportLocations[i], true);
                }

                IncrementProgressParallel();
            }
        }
    });
}


SetProgressBar(null, "Textures to rip", 0, textureCount);
StartProgressBarUpdater();

SetUMTConsoleText("Running...");

await Task.Run(() => ExecuteTextureBatch(texturesToRip));

await StopProgressBarUpdater();
HideProgressBar();

#region resource classes

public class GMSprite : GMResource
{
    public GMSprite(string name)
    {
        this.name = name;
    }

    public List<GMSpriteFrame> frames { get; set; }
    public List<GMImageLayer> layers { get; set; }

    public class GMSpriteFrame : GMResource
    {
        public UndertaleTexturePageItem? Texture { get; set; }

        public string resourceVersion { get; set; }
    }
    public class GMImageLayer : GMResource
    {
        public bool visible { get; set; } = true;
        public bool isLocked { get; set; }
        public int blendMode { get; set; }
        public float opacity { get; set; }
        public string displayName { get; set; }
    }
}

public class GMTileSet : GMResource
{
    public GMTileSet(string name)
    {
        this.name = name;
    }

    public AssetReference? spriteId { get; set; }
    public AssetReference parent { get; set; }

}

public class GMResource
{
    public GMResource()
    {
        resourceType = base.GetType().Name;
    }
    public string resourceType { get; set; }
    public string resourceVersion { get; set; } = "1.0";
    // ignore these conditions when they're null
    public string name { get; set; }
    public AssetReference? parent { get; set; }
    public string[] tags { get; set; }
}

public class AssetReference
{
    public string name { get; set; }
    public string path { get; set; }
}

public class GMProject : GMResource
{
    public List<GMIncludedFile> IncludedFiles { get; set; } = new();
    public class GMIncludedFile : GMResource
    {
        public GMIncludedFile(string name)
        {
            this.name = name;
        }
        public long CopyToMask { get; set; } = -1L;
        public string filePath { get; set; } = "datafiles";
    }
}

#endregion