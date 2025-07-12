/// @desc
player_input_device[0] = -2;
player_input_device[1] = -2;
switch_input_buffer = 0;
switch_operation_mode = switch_get_operation_mode();
switch_swap_ready_buffer = 0;
swap_cancelled = false;
switch_mode = 0;
switch_saved_input = -2;
mode = 0;
player_index = 0;
device_selected[0] = false;
device_selected[1] = false;
press_start = false;
deactivated = false;
device_to_reconnect = 0;
instance_list = ds_list_create();
sound_list = ds_list_create();
prevstate[0] = states.titlescreen;
prevstate[1] = states.titlescreen;
vibration[0][0] = 0;
vibration[0][1] = 0;
vibration[0][2] = 0;
vibration[1][0] = 0;
vibration[1][1] = 0;
vibration[1][2] = 0;

switch_get_single_player = function(_device)
{
	while (true)
	{
		switch_controller_joycon_set_holdtype(1);
		switch_controller_set_supported_styles(31);
		switch_controller_support_set_singleplayer_only(true);
		switch_controller_support_set_player_min(1);
		switch_controller_support_set_player_max(1);
		var result = switch_controller_support_show();
		if (result == 0)
		{
			player_input_device[_device] = switch_controller_support_get_selected_id();
			break;
		}
	}
};

for (var i = 0; i < gamepad_get_device_count(); i++)
{
	if (gamepad_is_connected(i))
	{
		device_selected[0] = true;
		player_input_device[0] = i;
		press_start = false;
	}
}

setVibration = function(_player, _lmotor, _rmotor, _strength)
{
	vibration[_player][0] = _lmotor;
	vibration[_player][1] = _rmotor;
	if (_strength != undefined)
	{
		vibration[_player][2] = _strength;
	}
};

/// @desc - Checks whether an input device is being used.
/// @arg {Bool} - The index of the input device.
/// @returns {Bool}
function CheckUsedIndex(_index)
{
	for (var _x = 0; _x < 2; _x++)
	{
		if (player_input_device[_x] == _index)
		{
			return true;
		}
	}
	return false;
}
