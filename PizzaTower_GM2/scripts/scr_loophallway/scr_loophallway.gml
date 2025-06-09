function scr_loophallway(_inst)
{
	if (_inst.start)
	{
		var yy = y - _inst.y;
		var _per = yy / _inst.sprite_height;
		with (obj_loophallway)
		{
			if (id != _inst.id && !start)
			{
				other.x = x + (sprite_width / 2);
				other.y = (y + (sprite_height * _per)) - 1;
				if (other.object_index == obj_vigilanteboss)
				{
					other.oldtargetspot = noone;
				}
			}
		}
	}
}
