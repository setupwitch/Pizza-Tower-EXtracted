using System;
using System.IO;
using System.Windows.Forms;
using System.Text.Json;
using UndertaleModLib.Util;
using System.Runtime.CompilerServices;
using System.Linq;
using System.Threading.Tasks;

EnsureDataLoaded();

string scriptDirectory = Path.GetDirectoryName(FilePath) + "\\";

// Work-around helper method to get the source file location.
private static string GetSourceFile([CallerFilePath] string file = "") => file;

string executionPath = Path.GetDirectoryName(Path.GetFullPath(GetSourceFile()));
string projectDirectory = Path.Combine(executionPath, "PizzaTower_GM2\\");

public JsonSerializerOptions jsonOptions = new() { AllowTrailingCommas = true, Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping, WriteIndented = true };

bool isProject = false;
while (!isProject)
{
    FolderBrowserDialog fbd = new()
    {
        Description = "Select GMS2 project folder.",
        UseDescriptionForTitle = true
    };

    if (fbd.ShowDialog() == DialogResult.OK)
    {
        projectDirectory = fbd.SelectedPath;
        // if it contains a yyp file.
        if (Directory.EnumerateFiles(projectDirectory, "*.yyp").Any())
            isProject = true;
    }
    else
    {
        throw new DirectoryNotFoundException("No directory chosen.");
    }
}

string yypPath = Directory.EnumerateFiles(projectDirectory, "*.yyp").First();

GMProject project = JsonSerializer.Deserialize<GMProject>(File.ReadAllText(yypPath), jsonOptions);

// obtain all of the necessary files to put into datafiles.

foreach (var file in project.IncludedFiles)
{
    string sourceFilePath = Path.Combine(scriptDirectory, file.filePath.Replace("datafiles", "").TrimStart('\\', '/'), file.name);
    string destFilePath = Path.Combine(projectDirectory, file.filePath, file.name);

    // Ensure destination directory exists
    Directory.CreateDirectory(Path.GetDirectoryName(destFilePath)!);

    // Copy file
    if (File.Exists(sourceFilePath))
        File.Copy(sourceFilePath, destFilePath, true);
    else
        Console.WriteLine($"Missing file: {sourceFilePath}");
}



// time for the main part.
string tilesetPath = Path.Combine(projectDirectory, "tilesets");
HashSet<string> tilesetSprites = new();

foreach (var tsDir in Directory.GetDirectories(tilesetPath))
{
    string tilesetName = Path.GetFileName(tsDir); // use GetFileName instead of GetDirectoryName
    string yyPath = Path.Combine(tsDir, $"{tilesetName}.yy");

    if (!File.Exists(yyPath))
        throw new FileNotFoundException(yyPath + " not found.");

    string json = File.ReadAllText(yyPath);
    var tileset = JsonSerializer.Deserialize<GMTileSet>(json, jsonOptions);
    if (tileset is not null && tileset.spriteId is not null)
        tilesetSprites.Add(tileset.spriteId.name);
}


string spritePath = Path.Combine(projectDirectory, "sprites");

string[] sprDirs = Directory.GetDirectories(spritePath);
TextureWorker tw = new();

SetProgressBar(null, "Sprite textures to dump", 0, sprDirs.Length - tilesetSprites.Count);
StartProgressBarUpdater();

SetUMTConsoleText("Running...");

var parallelOptions = new ParallelOptions { MaxDegreeOfParallelism = 4 }; // Limit to 2 threads
await Task.Run(() => Parallel.ForEach(sprDirs, parallelOptions, path =>
{
    ProcessSprite(path);
}));


void ProcessSprite(string sprDir)
{
    string spriteName = Path.GetFileName(sprDir); // use GetFileName instead of GetDirectoryName
    string yyPath = Path.Combine(sprDir, $"{spriteName}.yy");

    if (tilesetSprites.Contains(spriteName))
        return;

    if (!File.Exists(yyPath))
        throw new FileNotFoundException(yyPath + " not found.");

    string json = File.ReadAllText(yyPath);
    var sprite = JsonSerializer.Deserialize<GMSprite>(json, jsonOptions);

    int index = Data.Sprites
    .Select((sprite, idx) => new { sprite, idx })
    .Where(x => x.sprite.Name.Content == spriteName)
    .Select(x => x.idx)
    .DefaultIfEmpty(-1)
    .First();


    UndertaleSprite sprData = Data.Sprites[index];

    string layerDir = Path.Combine(sprDir, "layers");
    Directory.CreateDirectory(layerDir);
    foreach (GMSprite.GMImageLayer layer in sprite.layers)
    {
        for (int i = 0; i < sprite.frames.Count; i++)
        {
            GMSprite.GMSpriteFrame frame = sprite.frames[i];
            string frameDir = Path.Combine(layerDir, frame.name);
            Directory.CreateDirectory(frameDir);

            string pngPath = Path.Combine(frameDir, layer.name) + ".png";
            tw.ExportAsPNG(sprData.Textures[i].Texture, pngPath, null, true);

            File.Copy(pngPath, Path.Combine(sprDir, frame.name) + ".png", true);
        }
    }
    IncrementProgressParallel();
}

tw.Dispose();

await StopProgressBarUpdater();
HideProgressBar();
#region classes
// taken from my decompiler script
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