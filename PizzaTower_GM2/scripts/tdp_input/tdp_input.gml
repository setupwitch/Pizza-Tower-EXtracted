enum tdp_input_actiontypes
{
	keyboard = 0,
	gamepad_button = 1,
	gamepad_axis = 2,
}

function tdp_input_init()
{
	if (!variable_global_exists("input_list"))
	{
		global.input_list = ds_map_create();
		global.input_controller_deadzone = 0.4;
		global.input_controller_deadzone_vertical = 0.5;
		global.input_controller_deadzone_horizontal = 0.5;
		global.input_controller_deadzone_press = 0.5;
	}
}

function tdp_input_destroy()
{
	ds_map_destroy(global.input_list);
}

function tdp_input_add(_input)
{
	ds_map_set(global.input_list, _input.name, _input);
}

function tdp_input_update(_device = -1)
{
	gamepad_set_axis_deadzone(_device, global.input_controller_deadzone);
	var key = ds_map_find_first(global.input_list);
	var num = ds_map_size(global.input_list);
	for (var i = 0; i < num; i++)
	{
		global.input_list[? key].update(_device);
		key = ds_map_find_next(global.input_list, key);
	}
}

function tdp_input_get(_inputname)
{
	return ds_map_find_value(global.input_list, _inputname);
}

function tdp_input_ini_read(_inputkey, _input)
{
	tdp_input_deserialize(_inputkey, ini_read_string("Input", _inputkey, tdp_input_serialize(_input)));
}

function tdp_input_ini_write(_inputkey)
{
	ini_write_string("Input", _inputkey, tdp_input_serialize(_inputkey));
}

function tdp_input_serialize(_input)
{
	if (is_array(_input))
	{
		return tdp_input_serialize_array(_input);
	}
	else
	{
		return tdp_input_serialize_key(_input);
	}
}

function tdp_action(_type, _value, _joystickdir = 0)
{
	return 
	{
		type: _type,
		value: _value,
		joystick_direction: _joystickdir
	};
}

function tdp_input_serialize_key(_inputkey)
{
	var in = tdp_input_get(_inputkey);
	return tdp_input_serialize_array(in.actions);
}

function tdp_input_serialize_array(_inputarray)
{
	var str = "";
	for (var i = 0; i < array_length(_inputarray); i++)
	{
		var b = _inputarray[i];
		with (b)
		{
			str += string(type);
			str += ",";
			str += string(value);
			str += ",";
			if (type == tdp_input_actiontypes.gamepad_axis)
			{
				str += string(joystick_direction);
				str += ",";
			}
		}
	}
	return str;
}

function tdp_input_deserialize(_inputkey, _inputstr)
{
	var arr = string_split(_inputstr, ",");
	var in = new tdp_input_key(_inputkey);
	for (var i = 0; i < array_length(arr); i += 2)
	{
		if (arr[i] == "")
		{
			break;
		}
		var type = real(arr[i]);
		var value = real(arr[i + 1]);
		if (type == tdp_input_actiontypes.gamepad_axis)
		{
			var joystick_direction = real(arr[i + 2]);
			i++;
			array_push(in.actions, new tdp_input_action(type, value, joystick_direction));
		}
		else
		{
			array_push(in.actions, new tdp_input_action(type, value));
		}
	}
	tdp_input_add(in);
	show_debug_message(in);
}

function tdp_get_icons(_input)
{
	var arr = array_create(0);
	for (var i = 0; i < array_length(_input.actions); i++)
	{
		var q = tdp_get_icon(_input.actions[i]);
		if (q != noone)
		{
			array_push(arr, q);
		}
	}
	return arr;
}

function tdp_get_tutorial_icon(_inputkey)
{
	if (obj_inputAssigner.player_input_device[0] >= 0)
	{
		_inputkey += "C";
	}
	var in = tdp_input_get(_inputkey);
	for (var i = 0; i < array_length(in.actions); i++)
	{
		var q = tdp_get_icon(in.actions[i]);
		if (q != noone)
		{
			return q;
		}
	}
	return noone;
}

function tdp_get_icon(_input)
{
	switch (_input.type)
	{
		case tdp_input_actiontypes.keyboard:
			switch (_input.value)
			{
				case vk_shift:
				case vk_rshift:
				case vk_lshift:
					return 
					{
						sprite_index: spr_tutorialkeyspecial,
						image_index: 0,
						str: ""
					};
				case vk_control:
				case vk_lcontrol:
				case vk_rcontrol:
					return 
					{
						sprite_index: spr_tutorialkeyspecial,
						image_index: 1,
						str: ""
					};
				case vk_space:
					return 
					{
						sprite_index: spr_tutorialkeyspecial,
						image_index: 2,
						str: ""
					};
				case vk_up:
					return 
					{
						sprite_index: spr_tutorialkeyspecial,
						image_index: 3,
						str: ""
					};
				case vk_down:
					return 
					{
						sprite_index: spr_tutorialkeyspecial,
						image_index: 4,
						str: ""
					};
				case vk_right:
					return 
					{
						sprite_index: spr_tutorialkeyspecial,
						image_index: 5,
						str: ""
					};
				case vk_left:
					return 
					{
						sprite_index: spr_tutorialkeyspecial,
						image_index: 6,
						str: ""
					};
				case vk_escape:
					return 
					{
						sprite_index: spr_tutorialkeyspecial,
						image_index: 7,
						str: ""
					};
				default:
					return 
					{
						sprite_index: spr_tutorialkey,
						image_index: 0,
						str: scr_keyname(_input.value)
					};
			}
			break;
		case tdp_input_actiontypes.gamepad_button:
			switch (_input.value)
			{
				case gp_face1:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 0,
						str: ""
					};
				case gp_face2:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 1,
						str: ""
					};
				case gp_face3:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 2,
						str: ""
					};
				case gp_face4:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 3,
						str: ""
					};
				case gp_shoulderlb:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 4,
						str: ""
					};
				case gp_shoulderrb:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 5,
						str: ""
					};
				case gp_shoulderr:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 6,
						str: ""
					};
				case gp_shoulderl:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 7,
						str: ""
					};
				case gp_stickl:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 8,
						str: ""
					};
				case gp_stickr:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 9,
						str: ""
					};
				case gp_padu:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 10,
						str: ""
					};
				case gp_padr:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 11,
						str: ""
					};
				case gp_padd:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 12,
						str: ""
					};
				case gp_padl:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 13,
						str: ""
					};
				case gp_start:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 14,
						str: ""
					};
				case gp_select:
					return 
					{
						sprite_index: global.spr_gamepadbuttons,
						image_index: 15,
						str: ""
					};
			}
			break;
		case tdp_input_actiontypes.gamepad_axis:
			switch (_input.value)
			{
				case gp_axislh:
					if (_input.joystick_direction == -1)
					{
						return 
						{
							sprite_index: global.spr_joystick,
							image_index: 0,
							str: ""
						};
					}
					if (_input.joystick_direction == 1)
					{
						return 
						{
							sprite_index: global.spr_joystick,
							image_index: 1,
							str: ""
						};
					}
					break;
				case gp_axislv:
					if (_input.joystick_direction == -1)
					{
						return 
						{
							sprite_index: global.spr_joystick,
							image_index: 2,
							str: ""
						};
					}
					if (_input.joystick_direction == 1)
					{
						return 
						{
							sprite_index: global.spr_joystick,
							image_index: 3,
							str: ""
						};
					}
					break;
				case gp_axisrh:
					if (_input.joystick_direction == -1)
					{
						return 
						{
							sprite_index: global.spr_joystick,
							image_index: 4,
							str: ""
						};
					}
					if (_input.joystick_direction == 1)
					{
						return 
						{
							sprite_index: global.spr_joystick,
							image_index: 5,
							str: ""
						};
					}
					break;
				case gp_axisrv:
					if (_input.joystick_direction == -1)
					{
						return 
						{
							sprite_index: global.spr_joystick,
							image_index: 6,
							str: ""
						};
					}
					if (_input.joystick_direction == 1)
					{
						return 
						{
							sprite_index: global.spr_joystick,
							image_index: 7,
							str: ""
						};
					}
					break;
			}
			break;
	}
	return noone;
}
