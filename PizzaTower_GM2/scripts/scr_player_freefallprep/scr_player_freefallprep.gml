function scr_player_freefallprep()
{
	move = key_left + key_right;
	if (!grounded)
	{
		hsp = move * movespeed;
		if (move != xscale && momemtum == true && movespeed != 0)
		{
			movespeed -= 0.05;
		}
		if (movespeed == 0)
		{
			momemtum = false;
		}
		if ((move == 0 && momemtum == false) || scr_solid(x + hsp, y))
		{
			movespeed = 0;
			mach2 = 0;
		}
		if (move != 0 && movespeed < 7)
		{
			movespeed += 0.25;
		}
		if (movespeed > 7)
		{
			movespeed -= 0.05;
		}
		if ((scr_solid(x + 1, y) && move == 1) || (scr_solid(x - 1, y) && move == -1))
		{
			movespeed = 0;
		}
		if (dir != xscale)
		{
			mach2 = 0;
			dir = xscale;
			movespeed = 0;
		}
		if (move == -xscale)
		{
			mach2 = 0;
			movespeed = 0;
			momemtum = false;
		}
		if (move != 0)
		{
			xscale = move;
		}
		if (vsp > 0)
		{
			vsp = 0;
		}
	}
	image_speed = 0.5;
	if (ANIMATION_END)
	{
		state = states.freefall;
		if (shotgunAnim == false)
		{
			sprite_index = spr_bodyslamfall;
		}
		else
		{
			sprite_index = spr_shotgunjump3;
		}
	}
}
