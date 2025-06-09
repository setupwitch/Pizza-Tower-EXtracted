function noise_aftimg_set_pattern(_spr, _subimg)
{
	if (_spr == noone)
	{
		shader_set_uniform_i(global.N_Pattern_Enabled, 0);
		exit;
	}
	shader_set_uniform_i(global.N_Pattern_Enabled, 1);
	var _tex = sprite_get_texture(_spr, _subimg);
	texture_set_stage(global.N_Pattern_Tex, _tex);
	texture_set_interpolation_ext(global.N_Pattern_Tex, 0);
	var _uvs = sprite_get_uvs(_spr, _subimg);
	shader_set_uniform_f(global.N_Pattern_UVs, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
}
