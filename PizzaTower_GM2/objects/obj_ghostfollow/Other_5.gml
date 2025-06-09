if (object_index == obj_halloweenfollow && state == states.ghostcaught)
{
	with (obj_player1)
	{
		state = states.normal;
		landAnim = false;
		facehurt = true;
	}
}
destroy_sounds([snd]);
