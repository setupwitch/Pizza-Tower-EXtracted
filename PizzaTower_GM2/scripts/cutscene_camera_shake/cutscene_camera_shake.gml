function cutscene_camera_shake(_magnitude, _magnitude_acc)
{
	with (obj_camera)
	{
		shake_mag = _magnitude;
		shake_mag_acc = _magnitude_acc;
	}
	cutscene_end_action();
}
