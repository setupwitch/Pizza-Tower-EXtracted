function tdp_input_key(_keyname, _actions = noone) constructor
{
	static update = function(_device = -1)
	{
		pressed = false;
		held = false;
		released = false;
		axis_value = 0;
		for (var i = 0; i < array_length(actions); i++)
		{
			var b = actions[i];
			b.update(_device);
			if (b.pressed)
			{
				pressed = true;
			}
			if (b.held)
			{
				held = true;
			}
			if (b.released)
			{
				released = true;
			}
			actions[i] = b;
		}
	};
	
	static has_value = function(_type, _value, _joystickdir = 0)
	{
		for (var i = 0; i < array_length(actions); i++)
		{
			var b = actions[i];
			if (b.type == _type && b.value == _value)
			{
				if (_type != tdp_input_actiontypes.gamepad_axis || b.joystick_direction == _joystickdir)
				{
					return true;
				}
			}
		}
		return false;
	};
	
	static is_empty = function()
	{
		return array_length(actions) <= 0;
	};
	
	name = _keyname;
	pressed = false;
	held = false;
	released = false;
	axis_value = 0;
	if (_actions == noone)
	{
		actions = array_create(0);
	}
	else
	{
		actions = _actions;
	}
}

function tdp_input_action(_type, _value, _joystickdir = 0) constructor
{
	static update = function(_button = -1)
	{
		switch (type)
		{
			case tdp_input_actiontypes.keyboard:
				if (is_array(value))
				{
					var last_held = held;
					axis_value = keyboard_check(value[1]) - keyboard_check(value[0]);
					pressed = (keyboard_check_pressed(value[1]) - keyboard_check_pressed(value[0])) != 0;
					held = axis_value != 0;
					released = axis_value == 0 && last_held;
				}
				else
				{
					pressed = keyboard_check_pressed(value);
					held = keyboard_check(value);
					released = keyboard_check_released(value);
				}
				break;
			case tdp_input_actiontypes.gamepad_button:
				if (is_array(value))
				{
					var last_held = held;
					axis_value = gamepad_button_check(_button, value[1]) - gamepad_button_check(_button, value[0]);
					pressed = (gamepad_button_check_pressed(_button, value[1]) - gamepad_button_check_pressed(_button, value[0])) != 0;
					held = axis_value != 0;
					released = axis_value == 0 && last_held;
				}
				else
				{
					pressed = gamepad_button_check_pressed(_button, value);
					held = gamepad_button_check(_button, value);
					released = gamepad_button_check_released(_button, value);
				}
				break;
			case tdp_input_actiontypes.gamepad_axis:
				var _pindex = 0;
				if (instance_exists(obj_inputAssigner))
				{
					_pindex = obj_inputAssigner.player_index;
					if (_button != obj_inputAssigner.player_input_device[_pindex])
					{
						_pindex = !_pindex;
					}
				}
				var last_held = held;
				var hdz, vdz, pdz;
				if (!custom_deadzone)
				{
					pdz = global.input_controller_deadzone_press;
					hdz = global.input_controller_deadzone_horizontal;
					vdz = global.input_controller_deadzone_vertical;
				}
				else
				{
					pdz = variable_global_get(custom_deadzone_press);
					hdz = variable_global_get(custom_deadzone_horizontal);
					hdz = variable_global_get(custom_deadzone_vertical);
				}
				var dz;
				switch (value)
				{
					case gp_axislh:
					case gp_axisrh:
						dz = hdz;
						break;
					case gp_axislv:
					case gp_axisrv:
						dz = vdz;
						break;
				}
				axis_value = gamepad_axis_value(_button, value);
				var press_check;
				if (joystick_direction == 0)
				{
					press_check = axis_value > pdz || axis_value < -pdz;
					pressed = press_check && !stickpressed[_pindex];
					held = axis_value > dz || axis_value < -dz;
					released = axis_value > -dz && axis_value < dz && last_held;
				}
				else if (joystick_direction == 1)
				{
					press_check = axis_value > pdz;
					pressed = press_check && !stickpressed[_pindex];
					held = axis_value > dz;
					released = !held && last_held;
				}
				else if (joystick_direction == -1)
				{
					press_check = axis_value < -pdz;
					pressed = press_check && !stickpressed[_pindex];
					held = axis_value < -dz;
					released = !held && last_held;
				}
				if (press_check)
				{
					stickpressed[_pindex] = true;
				}
				else
				{
					stickpressed[_pindex] = false;
				}
				break;
		}
	};
	
	type = _type;
	value = _value;
	has_axis_value = false;
	axis_value = 0;
	if (type == tdp_input_actiontypes.gamepad_axis)
	{
		has_axis_value = true;
		custom_deadzone = false;
		joystick_direction = _joystickdir;
		custom_deadzone_press = "input_controller_deadzone_press";
		custom_deadzone_vertical = "input_controller_deadzone_vertical";
		custom_deadzone_horizontal = "input_controller_deadzone_deadzone";
		custom_deadzone_side = "input_controller_deadzone_side";
		axis_value = 0;
		stickpressed[0] = false;
		stickpressed[1] = false;
	}
	if (is_array(value))
	{
		has_axis_value = true;
		axis_value = 0;
	}
	pressed = false;
	held = false;
	released = false;
}
