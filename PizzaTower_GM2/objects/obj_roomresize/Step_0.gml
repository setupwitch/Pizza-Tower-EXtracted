if (obj_editor.editor_state != editorstates.resize_room)
{
	visible = false;
	exit;
}
with (obj_roomresize)
{
	if (dragged && id != other.id)
	{
		other.visible = false;
		exit;
	}
}
visible = true;
if (!dragged)
{
	var _room = global.current_level.current_room;
	if (_room != noone)
	{
		switch (dock)
		{
			case docks.top_left:
				x = _room.x;
				y = _room.y;
				break;
			case docks.top:
				x = _room.x + (_room.width / 2);
				y = _room.y;
				break;
			case docks.top_right:
				x = _room.x + _room.width;
				y = _room.y;
				break;
			case docks.right:
				x = _room.x + _room.width;
				y = _room.y + (_room.height / 2);
				break;
			case docks.bottom_right:
				x = _room.x + _room.width;
				y = _room.y + _room.height;
				break;
			case docks.bottom:
				x = _room.x + (_room.width / 2);
				y = _room.y + _room.height;
				break;
			case docks.bottom_left:
				x = _room.x;
				y = _room.y + _room.height;
				break;
			case docks.left:
				x = _room.x;
				y = _room.y + (_room.height / 2);
				break;
		}
		with (obj_editor)
		{
			var pos = editor_get_world_pos();
			var xx = pos[0];
			var yy = pos[1];
			if (key_place && !editor_is_cursor_on_ui(obj_editorcursor.x, obj_editorcursor.y) && place_meeting(xx, yy, other))
			{
				other.dragged = true;
				other.startx = _room.x;
				other.starty = _room.y;
				other.startwidth = _room.x + _room.width;
				other.startheight = _room.y + _room.height;
			}
		}
	}
}
else
{
	var pos = editor_get_world_pos();
	x = pos[0];
	y = pos[1];
	var _room = global.current_level.current_room;
	var _x = snap_tile(x, 32);
	var _y = snap_tile(y, 32);
	switch (dock)
	{
		case docks.top_left:
			_room.x = _x;
			_room.y = _y;
			_room.width = startwidth - _x;
			_room.height = startheight - _y;
			if (_room.width < 960)
			{
				_room.x = (_room.x + _room.width) - 960;
				_room.width = 960;
			}
			if (_room.height < 540)
			{
				_room.y = (_room.y + _room.height) - 540;
				_room.height = 540;
			}
			break;
		case docks.top:
			_room.y = _y;
			_room.height = startheight - _y;
			if (_room.height < 540)
			{
				_room.y = (_room.y + _room.height) - 540;
				_room.height = 540;
			}
			break;
		case docks.top_right:
			_room.y = _y;
			_room.width = _x - _room.x;
			_room.height = startheight - _y;
			if (_room.width < 960)
			{
				_room.width = 960;
			}
			if (_room.height < 540)
			{
				_room.y = (_room.y + _room.height) - 540;
				_room.height = 540;
			}
			break;
		case docks.right:
			_room.width = _x - _room.x;
			if (_room.width < 960)
			{
				_room.width = 960;
			}
			break;
		case docks.bottom_right:
			_room.width = _x - _room.x;
			_room.height = _y - _room.y;
			if (_room.width < 960)
			{
				_room.width = 960;
			}
			if (_room.height < 540)
			{
				_room.height = 540;
			}
			break;
		case docks.bottom:
			_room.height = _y - _room.y;
			if (_room.height < 540)
			{
				_room.height = 540;
			}
			break;
		case docks.bottom_left:
			_room.x = _x;
			_room.width = startwidth - _x;
			_room.height = _y - _room.y;
			if (_room.width < 960)
			{
				_room.x = (_room.x + _room.width) - 960;
				_room.width = 960;
			}
			if (_room.height < 540)
			{
				_room.height = 540;
			}
			break;
		case docks.left:
			_room.x = _x;
			_room.width = startwidth - _x;
			if (_room.width < 960)
			{
				_room.x = (_room.x + _room.width) - 960;
				_room.width = 960;
			}
			break;
	}
	if (obj_editor.key_place_released)
	{
		dragged = false;
	}
}
