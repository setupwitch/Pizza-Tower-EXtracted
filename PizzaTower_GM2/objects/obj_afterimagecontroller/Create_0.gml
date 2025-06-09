enum afterimagetype
{
	normal = 0,
	mach3effect = 1,
	heatattack = 2,
	firemouth = 3,
	blue = 4,
	blur = 5,
	red = 6,
	red_alt = 7,
	noise = 8,
	last = 9,
}

depth = 1;
global.afterimage_list = ds_list_create();
alpha = array_create(afterimagetype.last, 1);
alpha[afterimagetype.heatattack] = 0.5;
shd_alpha = shader_get_uniform(shd_firemouth_afterimage, "newAlpha");
shd_color_red = shader_get_uniform(shd_color_afterimage, "red");
shd_color_green = shader_get_uniform(shd_color_afterimage, "green");
shd_color_blue = shader_get_uniform(shd_color_afterimage, "blue");
