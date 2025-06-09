with (obj_music)
{
	if (music != noone)
	{
		fmod_event_instance_set_parameter(music.event, "state", 1, true);
	}
}
