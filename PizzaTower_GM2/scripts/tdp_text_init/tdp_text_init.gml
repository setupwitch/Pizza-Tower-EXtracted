function tdp_text_init()
{
	enum text_types
	{
		text = 0,
		icon = 1,
		array = 2,
	}
	
	enum text_effects
	{
		none = 0,
		shake = 1,
		wave = 2,
	}
	
	enum tokentypes
	{
		set = 0,
		identifier = 1,
		string = 2,
		constant = 3,
		last = 4,
	}
	
	global.tdp_text_surface = noone;
	global.tdp_text_queue = ds_queue_create();
	global.tdp_text_enabled = false;
	global.tdp_text_try_outline = false;
	global.tdp_text_shd_size = shader_get_uniform(shd_outline, "size");
	global.tdp_text_shd_color = shader_get_uniform(shd_outline, "oColor");
	global.tdp_text_shd_uvs = shader_get_uniform(shd_outline, "uvs");
}
