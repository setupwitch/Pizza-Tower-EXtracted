function scr_fakepeppino_jump()
{
	hsp = image_xscale * movespeed;
	if (sprite_index == spr_fakepeppino_jumpstart && ANIMATION_END)
	{
		image_index = 0;
		vsp = -15;
		sprite_index = spr_fakepeppino_jump;
		movespeed = 8;
	}
	if (sprite_index == spr_fakepeppino_jump && ANIMATION_END)
	{
		image_index = 0;
		sprite_index = spr_fakepeppino_fall;
	}
	if ((place_meeting(x, y + 1, obj_solid) || place_meeting(x, y + 1, obj_slope) || place_meeting(x, y + 1, obj_platform)) && sprite_index == spr_fakepeppino_fall)
	{
		image_index = 0;
		sprite_index = spr_fakepeppino_land;
		state = states.idle;
		movespeed = 0;
	}
}
