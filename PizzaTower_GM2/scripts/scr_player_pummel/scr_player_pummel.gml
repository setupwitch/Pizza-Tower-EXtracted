function scr_player_pummel()
{
	image_speed = 0.35;
	if (movespeed > 0)
	{
		movespeed -= 1;
	}
	if (movespeed <= 0)
	{
		movespeed = 0;
	}
	hsp = xscale * movespeed;
	if (sprite_index != spr_grab)
	{
		if (ANIMATION_END)
		{
			sprite_index = spr_grab;
			image_index = 0;
		}
	}
}
