function pattern_enable(_bool)
{
	shader_set_uniform_i(global.Pattern_Enable, _bool);
	shader_set_uniform_i(global.N_Pattern_Enabled, _bool);
}
