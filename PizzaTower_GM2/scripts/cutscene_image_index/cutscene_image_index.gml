function cutscene_image_index(_inst, _subimg)
{
	var _obj = _inst;
	var _index = _subimg;
	with (_obj)
	{
		image_index = _index;
	}
	cutscene_end_action();
}
