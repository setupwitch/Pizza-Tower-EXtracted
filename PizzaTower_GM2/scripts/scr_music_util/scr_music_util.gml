function add_music(_room, _event, _secretevent, _is_continuous, _roomstartfunc = noone)
{
	var b = 
	{
		continuous: _is_continuous,
		on_room_start: noone,
		value: 0,
		immediate: false,
		event: noone,
		event_secret: noone
	};
	with (b)
	{
		if (_roomstartfunc != noone)
		{
			on_room_start = method(self, _roomstartfunc);
		}
		if (_event != noone)
		{
			event_name = _event;
			event = fmod_event_create_instance(_event);
		}
		if (_secretevent != noone)
		{
			event_secret_name = _secretevent;
			event_secret = fmod_event_create_instance(_secretevent);
		}
	}
	ds_map_set(music_map, _room, b);
	return b;
}

function stop_music()
{
	with (obj_music)
	{
		if (music != noone)
		{
			if (obj_pause.pause)
			{
				fmod_event_instance_stop(music.event, true);
				fmod_event_instance_stop(music.event_secret, true);
			}
			else
			{
				fmod_event_instance_stop(music.event, false);
				fmod_event_instance_stop(music.event_secret, false);
			}
		}
		fmod_event_instance_stop(pillarmusicID, true);
		fmod_event_instance_stop(panicmusicID, true);
	}
}

function hub_state(_hubroom, _snd, arg2)
{
	var s = 0;
	switch (_hubroom)
	{
		case tower_1:
		case tower_1up:
		case tower_cheftask1:
		case tower_johngutterhall:
		case tower_ruinsecret:
			s = 0;
			break;
		case tower_2:
		case tower_2up:
		case tower_cheftask2:
		case tower_ravine:
			s = 1;
			break;
		case tower_3:
		case tower_3up:
		case tower_cheftask3:
		case tower_pizzaland:
			s = 2;
			break;
		case tower_4:
		case tower_4up:
		case tower_cheftask4:
		case tower_graffiti:
		case tower_noisettecafe:
			s = 3;
			break;
		case tower_5:
		case tower_cheftask5:
		case tower_laundryroom:
		case tower_mansion:
			s = 4;
			break;
	}
	fmod_event_instance_set_parameter(_snd, "hub", s, false);
}

function music_get_pos_wrap(_pos, _length)
{
	while (_pos > _length)
	{
		_pos -= _length;
	}
	if (_pos < 1)
	{
		_pos = 1;
	}
	return _pos;
}
