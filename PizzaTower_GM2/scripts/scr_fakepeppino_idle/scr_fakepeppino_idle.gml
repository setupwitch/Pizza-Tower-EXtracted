function scr_fakepeppino_idle()
{
	hsp = image_xscale * movespeed;
	if (x != obj_player.x)
	{
		image_xscale = -sign(x - obj_player.x);
	}
	if (sprite_index == spr_fakepeppino_land && ANIMATION_END)
	{
		image_index = 0;
		sprite_index = spr_fakepeppino_idle;
	}
	if (sprite_index == spr_fakepeppino_idle && ANIMATION_END)
	{
		movespeed = 8;
		image_index = 0;
		sprite_index = spr_fakepeppino_walk;
		state = states.walk;
	}
}
