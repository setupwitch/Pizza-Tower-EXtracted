function scr_player_portal()
{
	if (ANIMATION_END && sprite_index == spr_pizzaportalentrancestart)
	{
		instance_create(x, y, obj_pizzaportalfade);
		state = states.freefall;
		grav = 0.5;
	}
	mach2 = 0;
}
