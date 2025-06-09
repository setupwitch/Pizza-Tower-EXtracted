if (ANIMATION_END && obj_player.state != states.door)
{
	with (obj_player)
	{
		state = states.door;
		image_index = 0;
	}
	alarm[0] = 200;
}
if (ANIMATION_END)
{
	image_speed = 0;
}
