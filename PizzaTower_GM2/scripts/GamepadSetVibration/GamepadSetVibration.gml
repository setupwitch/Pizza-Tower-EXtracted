function GamepadSetVibration(_player, _left, _right, _strength)
{
	with (obj_inputAssigner)
	{
		setVibration(_player, _left, _right, _strength);
	}
}
