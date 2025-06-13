if (!global.panic)
{
	var mu = ds_map_find_value(music_map, room);
	if (!is_undefined(mu))
	{
		var prevmusic = music;
		if (prevmusic == noone || mu.event_name != prevmusic.event_name)
		{
			fmod_event_instance_play(mu.event);
			fmod_event_instance_set_paused(mu.event, false);
			if (mu.continuous && prevmusic != noone)
			{
				var pos = fmod_event_instance_get_timeline_pos(prevmusic.event);
				pos = music_get_pos_wrap(pos, fmod_event_get_length(mu.event_name));
				fmod_event_instance_set_timeline_pos(mu.event, pos);
			}
			if (prevmusic != noone)
			{
				if (room == Mainmenu)
				{
					fmod_event_instance_stop(prevmusic.event, false);
				}
				else
				{
					fmod_event_instance_stop(prevmusic.event, true);
				}
				if (prevmusic.event_secret != noone)
				{
					fmod_event_instance_stop(prevmusic.event_secret, true);
				}
			}
			music = mu;
			savedmusicpos = 0;
			if (room == war_1 || room == tower_finalhallway)
			{
				fmod_event_instance_stop(music.event, true);
			}
		}
	}
	if (instance_exists(obj_hungrypillar))
	{
		fmod_event_instance_play(pillarmusicID);
		fmod_set_parameter("pillarfade", 0, true);
	}
	else
	{
		fmod_event_instance_stop(pillarmusicID, true);
	}
	if (music != noone && music.on_room_start != noone)
	{
		music.on_room_start(room, music.event, music.event_secret);
	}
}
if (!instance_exists(obj_randomsecret))
{
	if (secret)
	{
		if (music != noone && music.event_secret != noone)
		{
			fmod_event_instance_play(music.event_secret);
			fmod_event_instance_set_paused(music.event_secret, false);
			var pos = fmod_event_instance_get_timeline_pos(music.event);
			savedmusicpos = pos;
			pos = music_get_pos_wrap(pos, fmod_event_get_length(music.event_secret_name));
			fmod_event_instance_set_timeline_pos(music.event_secret, pos);
			fmod_event_instance_set_paused(music.event, true);
		}
		if (global.panic)
		{
			trace("Pausing panic music: room_start");
			savedpanicpos = fmod_event_instance_get_timeline_pos(panicmusicID);
			fmod_event_instance_set_paused(panicmusicID, true);
		}
	}
	else if (secretend)
	{
		secretend = false;
		if (music != noone)
		{
			fmod_event_instance_stop(music.event_secret, true);
			fmod_event_instance_set_paused(music.event, false);
			fmod_event_instance_set_timeline_pos(music.event, savedmusicpos);
		}
		if (global.panic)
		{
			fmod_event_instance_set_timeline_pos(panicmusicID, savedpanicpos);
			fmod_event_instance_set_paused(panicmusicID, false);
			trace("Resuming panic music: room_start");
		}
	}
}
if (room == rank_room || room == boss_pizzaface || room == boss_noise || room == boss_vigilante || room == boss_fakepep || room == boss_pepperman)
{
	if (music != noone)
	{
		fmod_event_instance_stop(music.event, true);
		fmod_event_instance_stop(music.event_secret, true);
	}
}
