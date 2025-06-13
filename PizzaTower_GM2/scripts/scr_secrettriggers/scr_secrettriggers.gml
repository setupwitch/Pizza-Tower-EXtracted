function secret_add(_func1, _func2)
{
	with (obj_secretmanager)
	{
		ds_list_add(secrettriggers, [_func2]);
		if (_func1 != noone)
		{
			method(id, _func1)();
		}
	}
}

function secret_add_touchall(_room, _trigger, _id)
{
	with (obj_secretmanager)
	{
		ds_list_add(touchall, [_room, _trigger, _id]);
	}
}

function secret_add_touchall_requirement(_index, _trigger)
{
	touchrequirement[_index] = [_trigger, false];
}

function secret_check_touchall()
{
	if (touchrequirement != noone && is_array(touchrequirement))
	{
		for (var xx = 0; xx < array_length(touchrequirement); xx++)
		{
			var t = bg_chateauscrolldeco;
			for (var i = 0; i < ds_list_size(touchall); i++)
			{
				b = ds_list_find_value(touchall, i);
				if (b[1] == xx)
				{
					t++;
				}
			}
			if (t == touchrequirement[xx][0])
			{
				touchrequirement[xx][1] = true;
			}
		}
		var b = true;
		for (var i = 0; i < array_length(touchrequirement); i++)
		{
			if (!touchrequirement[i][1])
			{
				b = false;
				break;
			}
		}
		if (b)
		{
			return true;
		}
	}
	return false;
}

function secret_check_trigger(_trigger)
{
	var _found = false;
	with (obj_secrettrigger)
	{
		if (trigger == _trigger && active)
		{
			_found = true;
		}
	}
	if (_found)
	{
		trace(
		{
			found: _found
		});
	}
	return _found;
}

function secret_open_portal(_trigger)
{
	with (obj_secretportal)
	{
		if (trigger == _trigger && ds_list_find_index(global.saveroom, id) == -1 && !place_meeting(x, y, obj_marbleblock) && !place_meeting(x, y, obj_secretblock) && !place_meeting(x, y, obj_secretbigblock) && !place_meeting(x, y, obj_secretmetalblock) && !place_meeting(x, y, obj_secretdestroyable))
		{
			active = true;
		}
	}
}

function secret_close_portal(_trigger, _quick = false)
{
	with (obj_secretportal)
	{
		if (trigger == _trigger && sprite_index != spr_secretportal_close)
		{
			sprite_index = spr_secretportal_close;
			if (!_quick)
			{
				image_index = 0;
			}
			else
			{
				image_index = 14;
			}
			active = false;
		}
	}
}

function secret_close_portalID(_inst)
{
	with (_inst)
	{
		sprite_index = spr_secretportal_close;
		image_index = 14;
		active = false;
	}
}
