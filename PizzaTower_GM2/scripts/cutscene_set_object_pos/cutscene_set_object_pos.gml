function cutscene_set_object_pos(_object, _x, _y)
{
	with (_object)
	{
		x = _x;
		y = _y;
	}
	cutscene_end_action();
}
