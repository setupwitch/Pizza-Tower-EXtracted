function scr_button_pressed(_device)
{
	if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(global.key_jump) || keyboard_check_pressed(global.key_jumpN))
	{
		return -1;
	}
	else
	{
		var _face = gp_face1;
		if (gamepad_is_connected(_device))
		{
			if (gamepad_button_check_pressed(_device, _face) || gamepad_button_check_pressed(_device, gp_start))
			{
				return _device;
			}
		}
	}
	return -2;
}
