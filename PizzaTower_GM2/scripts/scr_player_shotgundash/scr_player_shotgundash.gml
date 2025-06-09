function scr_player_shotgundash()
{
	image_speed = 0.35;
	hsp = xscale * movespeed;
	if (ANIMATION_END || !key_attack)
	{
		state = states.shotgun;
		sprite_index = spr_shotgunidle;
		landAnim = false;
		movespeed = 6;
		if (!grounded)
		{
			state = states.shotgunjump;
			sprite_index = spr_shotgunfall;
		}
	}
}
