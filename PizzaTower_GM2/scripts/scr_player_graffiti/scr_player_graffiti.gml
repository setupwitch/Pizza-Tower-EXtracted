function scr_player_graffiti()
{
	hsp = 0;
	vsp = -grav;
	image_speed = 0.5;
	if (ANIMATION_END)
	{
		state = states.normal;
		if (tauntstoredisgustavo)
		{
			state = states.ratmount;
		}
		if (global.graffiticount >= global.graffitimax)
		{
			instance_create(x, y, obj_key);
		}
	}
}
