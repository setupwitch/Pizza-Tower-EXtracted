for (var j = 0; j < array_length(menus); j++)
{
	var m = menus[j];
	for (var i = 0; i < array_length(m.options); i++)
	{
		var b = m.options[i];
		if (b.type == optiontypes.slide)
		{
			if (b.sound != noone)
			{
				fmod_event_instance_stop(b.sound, true);
				fmod_event_instance_release(b.sound);
			}
		}
	}
}
