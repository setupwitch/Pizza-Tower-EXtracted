function scr_player_hang()
{
	hsp = 0;
	if (sprite_index == spr_playerN_wallclingstart && ANIMATION_END)
	{
		sprite_index = spr_playerN_wallcling;
	}
	vsp = 0;
	wallclingcooldown = 0;
	if (ANIMATION_END)
	{
		jumpstop = false;
		vsp = -15;
		state = states.jump;
		sprite_index = spr_playerN_noisebombspinjump;
		image_index = 0;
		with (instance_create(x, y, obj_jumpdust))
		{
			image_xscale = other.xscale;
		}
	}
	image_speed = 0.35;
}
