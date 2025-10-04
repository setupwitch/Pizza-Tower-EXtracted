scr_get_languages();
global.texture_load_count = ds_list_create();
tex_list = noone;
var group_arr = ["hubgroup", "playergroup", "noisegroup", "introgroup", "smallgroup", "hudgroup", "levelstructuregroup", "baddiegroup"];
tex_list = array_create(0);
tex_pos = 0;
for (var i = 0; i < array_length(group_arr); i++)
{
	var _tex_array = texturegroup_get_textures(group_arr[i]);
	for (var j = 0; j < array_length(_tex_array); j++)
	{
		array_push(tex_list, _tex_array[j]);
	}
}
tex_max = array_length(tex_list);
ext_tex_pos = 0;
lang_max = ds_queue_size(global.lang_to_load);
lang_tex_max = 0;
var arr = [];
var file = file_find_first("lang/graphics/", 0);
while (file != "")
{
	lang_tex_max++;
	file = file_find_next();
}
lang_tex_max -= lang_max;
lang_tex = lang_tex_max;
file_find_close();
lang_init = false;
alarm[0] = 70;
