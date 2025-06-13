function Approach(_val1, _val2, _amount)
{
	if (_val1 < _val2)
	{
		_val1 += _amount;
		if (_val1 > _val2)
		{
			return _val2;
		}
	}
	else
	{
		_val1 -= _amount;
		if (_val1 < _val2)
		{
			return _val2;
		}
	}
	return _val1;
}

function get_milliseconds()
{
	return get_timer() / 1000;
}

function camera_zoom(_zoom, _zoomspd)
{
	with (obj_camera)
	{
		targetzoom = _zoom;
		targetzoom = clamp(targetzoom, 0, max_zoom);
		if (_zoomspd != undefined)
		{
			zoomspd = abs(_zoomspd);
		}
	}
}

function camera_set_zoom(_zoom)
{
	with (obj_camera)
	{
		zoom = _zoom;
	}
}

function try_solid(_xspd, _yspd, _obj, _iteration_count)
{
	var old_x = x;
	var old_y = y;
	var n = -1;
	for (var i = 0; i < _iteration_count; i++)
	{
		x += _xspd;
		y += _yspd;
		if (!scr_solid(x, y))
		{
			n = i + 1;
			break;
		}
	}
	x = old_x;
	y = old_y;
	return n;
}

function ledge_bump_vertical(_iteration_count, _yspd)
{
	var old_x = x;
	var old_y = y;
	y += (_yspd * 4);
	var dirs = [-1, 1];
	for (var i = 0; i < array_length(dirs); i++)
	{
		var ledge_dir = dirs[i];
		var tx = try_solid(ledge_dir, 0, obj_solid, _iteration_count);
		y = old_y;
		if (tx != -1)
		{
			x -= (tx * ledge_dir);
			y += _yspd;
			if (scr_solid(x, y))
			{
				x = old_x;
				y = old_y;
				return true;
			}
			return false;
		}
	}
	return true;
}

function ledge_bump(_iteration_count, _xspd = 4)
{
	var old_x = x;
	var old_y = y;
	x += (xscale * _xspd);
	var ty = try_solid(0, -1, obj_solid, _iteration_count);
	x = old_x;
	if (ty != -1)
	{
		y -= ty;
		x += xscale;
		if (scr_solid(x, y))
		{
			x = old_x;
			y = old_y;
			return true;
		}
		with (obj_camera)
		{
			offset_y += ty;
		}
		return false;
	}
	return true;
}

function instance_create_unique(_x, _y, _obj)
{
	if (instance_exists(_obj))
	{
		return noone;
	}
	var b = instance_create(_x, _y, _obj);
	return b;
}

function get_solid_difference(_xspd, _yspd, _iteration_count)
{
	var old_x = x;
	var old_y = y;
	var n = 0;
	for (var i = 0; i < _iteration_count; i++)
	{
		x += _xspd;
		y += _yspd;
		if (!scr_solid(x, y))
		{
			n++;
		}
	}
	x = old_x;
	y = old_y;
	return n;
}

function trace()
{
	var _string = "";
	for (var i = 0; i < argument_count; i++)
	{
		_string += string(argument[i]);
	}
	show_debug_message(_string);
}

function concat()
{
	var _string = "";
	for (var i = 0; i < argument_count; i++)
	{
		_string += string(argument[i]);
	}
	return _string;
}

function embed_value_string(_str, _array)
{
	var str_copy = string_copy(_str, 1, string_length(_str));
	for (var i = 0; i < array_length(_array); i++)
	{
		var b = string(_array[i]);
		str_copy = string_replace(str_copy, "%", b);
	}
	return str_copy;
}

function ds_list_add_unique(_val)
{
	if (argument_count > 1)
	{
		for (var i = 1; i < argument_count; i++)
		{
			var b = argument[i];
			if (ds_list_find_index(_val, b) == -1)
			{
				ds_list_add(_val, b);
			}
		}
	}
}

function point_in_camera(_x, _y, _cam)
{
	var cam_x = camera_get_view_x(_cam);
	var cam_y = camera_get_view_y(_cam);
	var cam_w = camera_get_view_width(_cam);
	var cam_h = camera_get_view_height(_cam);
	return point_in_rectangle(_x, _y, cam_x, cam_y, cam_x + cam_w, cam_y + cam_h);
}

function point_in_camera_ext(_x, _y, _cam, _width, _height)
{
	var cam_x = camera_get_view_x(_cam);
	var cam_y = camera_get_view_y(_cam);
	var cam_w = camera_get_view_width(_cam);
	var cam_h = camera_get_view_height(_cam);
	return point_in_rectangle(_x, _y, cam_x - _width, cam_y - _height, cam_x + cam_w + _width, cam_y + cam_h + _height);
}

function bbox_in_camera(_cam, _threshold = 0)
{
	var cam_x = camera_get_view_x(_cam);
	var cam_y = camera_get_view_y(_cam);
	var cam_w = camera_get_view_width(_cam);
	var cam_h = camera_get_view_height(_cam);
	return bbox_left < (cam_x + cam_w + _threshold) && bbox_right > (cam_x - _threshold) && bbox_top < (cam_y + cam_h + _threshold) && bbox_bottom > (cam_y - _threshold);
}

function instance_nearest_random(_obj, _range)
{
	var l = instance_furthest(x, y, _obj);
	var list = ds_list_create();
	for (var i = 0; i < instance_number(_obj); i++)
	{
		b = instance_find(_obj, i);
		var t = distance_to_object(b);
		if (t <= l)
		{
			ds_list_add(list, b);
		}
	}
	var b = undefined;
	if (ds_list_size(list) > 0)
	{
		var n = irandom(_range);
		if (ds_list_size(list) < n)
		{
			n = ds_list_size(list) - 1;
		}
		b = ds_list_find_value(list, ds_list_size(list) - n);
	}
	ds_list_destroy(list);
	return b;
}

function instance_random(_obj)
{
	return instance_find(_obj, irandom(instance_number(_obj) - 1));
}

function heat_calculate(_val)
{
	return _val;
}
