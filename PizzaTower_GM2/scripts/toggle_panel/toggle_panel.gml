function toggle_panel(_id)
{
	var _closed = false;
	with (obj_panel)
	{
		if (ID == _id && state == states.revolver)
		{
			_closed = true;
		}
	}
	if (_closed)
	{
		with (obj_panel)
		{
			if (ID == _id)
			{
				state = states.normal;
			}
			else if (ID != noone)
			{
				state = states.revolver;
			}
		}
	}
	else
	{
		with (obj_panel)
		{
			if (ID != noone)
			{
				state = states.revolver;
			}
		}
	}
}
