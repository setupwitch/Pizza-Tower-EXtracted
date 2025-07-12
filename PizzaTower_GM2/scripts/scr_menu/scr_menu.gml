enum menuids
{
	categories = 0,
	audio = 1,
	video = 2,
	window = 3,
	resolution = 4,
	unknown5 = 5, // related to video.
	game = 6,
	controls = 7,
	controller = 8,
	keyboard = 9,
	deadzones = 10,
	last = 11, // related to controls.
}

enum menutypes
{
	toggle = 0,
	multi = 1,
	press = 2,
	slider = 3,
}

enum menuanchors
{
	center = 0,
	left = 1,
}

function menu_goto(_menuid)
{
	menu = 0;
	for (var i = 0; i < array_length(menus); i++)
	{
		var b = menus[i];
		if (b.menu_id == _menuid)
		{
			menu = i;
			break;
		}
	}
	optionselected = 0;
}

function create_menu_fixed(_menuid, _anchor, _xpadding, _ypadding, _backmenu = menuids.categories)
{
	return 
	{
		menu_id: _menuid,
		type: menutypes.toggle,
		anchor: _anchor,
		xpad: _xpadding,
		ypad: _ypadding,
		backmenu: _backmenu,
		options: []
	};
}

function add_option_press(_menu, _optionid, _name, _func)
{
	var b = 
	{
		option_id: _optionid,
		type: menutypes.press,
		func: _func,
		name: _name,
		localization: true
	};
	array_push(_menu.options, b);
	return b;
}

function add_option_toggle(_menu, _optionid, _name, _onchangedfunc = noone)
{
	var b = 
	{
		option_id: _optionid,
		type: menutypes.toggle,
		value: false,
		name: _name,
		on_changed: _onchangedfunc
	};
	array_push(_menu.options, b);
	return b;
}

function add_option_multiple(_menu, _optionid, _name, _values, _onchangedfunc = noone)
{
	var b = 
	{
		option_id: _optionid,
		type: menutypes.multi,
		values: _values,
		value: 0,
		name: _name,
		on_changed: _onchangedfunc
	};
	array_push(_menu.options, b);
	return b;
}

function create_option_value(_name, _value, _localization = true)
{
	return 
	{
		name: _name,
		value: _value,
		localization: _localization
	};
}

function add_option_slide(_menu, _optionid, _name, _onmovefunc = noone, _onchangedfunc = noone, _sound = noone)
{
	var b = 
	{
		option_id: _optionid,
		type: menutypes.slider,
		value: 100,
		moved: false,
		name: _name,
		on_changed: _onchangedfunc,
		on_move: _onmovefunc,
		slidecount: 0,
		moving: false,
		sound: noone
	};
	if (_sound != noone)
	{
		b.sound = fmod_event_create_instance(_sound);
	}
	array_push(_menu.options, b);
	return b;
}

function menu_draw_text(_x, _y, _str, _color, _alpha)
{
	var _break = false;
	var sub = false;
	var newstr = string_replace_all(_str, "\\n", "\n");
	if (string_length(newstr) != string_length(_str))
	{
		_break = true;
		sub = true;
		_str = newstr;
		tdp_draw_set_font(lang_get_font("smallfont"));
	}
	tdp_draw_text_color(_x, _y + (_break ? 2 : 0), _str, _color, _color, _color, _color, _alpha);
	if (sub)
	{
		tdp_draw_set_font(lang_get_font("bigfont"));
	}
	return _break;
}

function menu_lang_value(_langstr)
{
	var text = lang_get_value(_langstr);
	switch (_langstr)
	{
		case "option_controller_superjump":
		case "option_controller_groundpound":
			text = string_replace_all(text, "%", lang_get_value("joystick_steam"));
			break;
	}
	return text;
}
