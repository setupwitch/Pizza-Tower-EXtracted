function cutscene_player_float(_float)
{
	with (obj_player)
	{
		float = _float;
	}
	cutscene_end_action();
}
