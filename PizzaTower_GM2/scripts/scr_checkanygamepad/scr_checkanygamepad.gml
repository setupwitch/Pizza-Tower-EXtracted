function scr_checkanystick(_device, _threshold = 0.5)
{
	if (gamepad_axis_value(_device, gp_axislh) > _threshold || gamepad_axis_value(_device, gp_axislh) < -_threshold)
	{
		return true;
	}
	if (gamepad_axis_value(_device, gp_axislv) > _threshold || gamepad_axis_value(_device, gp_axislv) < -_threshold)
	{
		return true;
	}
	if (gamepad_axis_value(_device, gp_axisrh) > _threshold || gamepad_axis_value(_device, gp_axisrh) < -_threshold)
	{
		return true;
	}
	if (gamepad_axis_value(_device, gp_axisrv) > _threshold || gamepad_axis_value(_device, gp_axisrv) < -_threshold)
	{
		return true;
	}
}

function scr_check_menu_key(_key)
{
	return global.key_start != _key && global.key_slap != _key && global.key_taunt != _key;
}

function scr_check_menu_repeats(_inputname, _key, _is_gamepad)
{
	if (!_is_gamepad && _key == vk_escape && (_inputname == "menu_back" || _inputname == "menu_start"))
	{
		return true;
	}
	var query = [];
	for (var i = 0; i < array_length(input); i++)
	{
		var in = input[i];
		if (in[0] != "menu_quit" && in[0] != _inputname && string_copy(input[i][0], 0, 4) == "menu")
		{
			array_push(query, concat(input[i][0], _is_gamepad ? "C" : ""));
		}
	}
	for (var i = 0; i < array_length(query); i++)
	{
		var in = tdp_input_get(query[i]);
		if (!_is_gamepad)
		{
			if (in.has_value(tdp_input_actiontypes.keyboard, _key))
			{
				return false;
			}
		}
		else if (is_array(_key))
		{
			if (in.has_value(tdp_input_actiontypes.gamepad_axis, _key[0], _key[1]))
			{
				return false;
			}
		}
		else if (in.has_value(tdp_input_actiontypes.gamepad_button, _key))
		{
			return false;
		}
	}
	return true;
}

function scr_checkanygamepad(_device)
{
	if (gamepad_button_check_pressed(_device, gp_face1))
	{
		return gp_face1;
	}
	else if (gamepad_button_check_pressed(_device, gp_face2))
	{
		return gp_face2;
	}
	else if (gamepad_button_check_pressed(_device, gp_face3))
	{
		return gp_face3;
	}
	else if (gamepad_button_check_pressed(_device, gp_face4))
	{
		return gp_face4;
	}
	else if (gamepad_button_check_pressed(_device, gp_shoulderl))
	{
		return gp_shoulderl;
	}
	else if (gamepad_button_check_pressed(_device, gp_shoulderlb))
	{
		return gp_shoulderlb;
	}
	else if (gamepad_button_check_pressed(_device, gp_shoulderr))
	{
		return gp_shoulderr;
	}
	else if (gamepad_button_check_pressed(_device, gp_shoulderrb))
	{
		return gp_shoulderrb;
	}
	else if (gamepad_button_check_pressed(_device, gp_select))
	{
		return gp_select;
	}
	else if (gamepad_button_check_pressed(_device, gp_start))
	{
		return gp_start;
	}
	else if (gamepad_button_check_pressed(_device, gp_stickl))
	{
		return gp_stickl;
	}
	else if (gamepad_button_check_pressed(_device, gp_stickr))
	{
		return gp_stickr;
	}
	else if (gamepad_button_check_pressed(_device, gp_padu))
	{
		return gp_padu;
	}
	else if (gamepad_button_check_pressed(_device, gp_padd))
	{
		return gp_padd;
	}
	else if (gamepad_button_check_pressed(_device, gp_padl))
	{
		return gp_padl;
	}
	else if (gamepad_button_check_pressed(_device, gp_padr))
	{
		return gp_padr;
	}
	else if (gamepad_button_check_pressed(_device, gp_axislh))
	{
		return gp_axislh;
	}
	else if (gamepad_button_check_pressed(_device, gp_axislv))
	{
		return gp_axislv;
	}
	else if (gamepad_button_check_pressed(_device, gp_axisrh))
	{
		return gp_axisrh;
	}
	else if (gamepad_button_check_pressed(_device, gp_axisrv))
	{
		return gp_axisrv;
	}
	return noone;
}

function scr_check_joysticks(_device)
{
	if (gamepad_axis_value(_device, gp_axislh) > 0.5)
	{
		return [gp_axislh, 1];
	}
	if (gamepad_axis_value(_device, gp_axislh) < -0.5)
	{
		return [gp_axislh, -1];
	}
	if (gamepad_axis_value(_device, gp_axislv) > 0.5)
	{
		return [gp_axislv, 1];
	}
	if (gamepad_axis_value(_device, gp_axislv) < -0.5)
	{
		return [gp_axislv, -1];
	}
	if (gamepad_axis_value(_device, gp_axisrh) > 0.5)
	{
		return [gp_axisrh, 1];
	}
	if (gamepad_axis_value(_device, gp_axisrh) < -0.5)
	{
		return [gp_axisrh, -1];
	}
	if (gamepad_axis_value(_device, gp_axisrv) > 0.5)
	{
		return [gp_axisrv, 1];
	}
	if (gamepad_axis_value(_device, gp_axisrv) < -0.5)
	{
		return [gp_axisrv, -1];
	}
	return noone;
}
