function cutscene_change_room(_room)
{
	with (obj_player)
	{
		targetRoom = _room;
	}
	instance_create(x, y, obj_fadeout);
	if (room == _room)
	{
		cutscene_end_action();
	}
}
