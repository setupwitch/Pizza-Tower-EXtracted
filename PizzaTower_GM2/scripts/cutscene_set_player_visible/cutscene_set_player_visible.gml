function cutscene_set_player_visible(_visible)
{
	with (obj_player)
	{
		visible = _visible;
	}
	cutscene_end_action();
}
