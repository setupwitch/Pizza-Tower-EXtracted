function add_achievement_update(_name, _update_rate, _creationcode, _updatefunc, _unlock = true, _ini_section = noone, _ini_key = noone)
{
	var q = 
	{
		name: _name,
		update_rate: _update_rate,
		frames: 0,
		update_func: noone,
		creation_code: noone,
		variables: ds_map_create(),
		unlocked: false
	};
	q.update_func = method(q, _updatefunc);
	if (_creationcode != noone)
	{
		q.creation_code = method(q, _creationcode);
		q.creation_code();
	}
	if (_unlock == false)
	{
		ini_open_from_string(obj_savesystem.ini_str_options);
		if (ini_read_real(_ini_section, _ini_key, false) == true)
		{
			trace(_ini_key, " already unlocked");
			q.unlocked = true;
			ini_close();
			exit;
		}
		ini_close();
	}
	array_push(obj_achievementtracker.achievements_update, q);
	return q;
}

function add_achievement_notify(_name, _creationcode, _func, _unlock = true, _ini_section = noone, _ini_key = noone)
{
	var q = 
	{
		name: _name,
		creation_code: noone,
		func: noone,
		unlocked: false,
		variables: ds_map_create()
	};
	q.func = method(q, _func);
	if (_creationcode != noone)
	{
		q.creation_code = method(q, _creationcode);
		q.creation_code();
	}
	if (_unlock == false)
	{
		ini_open_from_string(obj_savesystem.ini_str_options);
		if (ini_read_real(_ini_section, _ini_key, false) == true)
		{
			trace(_ini_key, " already unlocked");
			q.unlocked = true;
			ini_close();
			exit;
		}
		ini_close();
	}
	array_push(obj_achievementtracker.achievements_notify, q);
	return q;
}

function notification_push(_notification, _array)
{
	trace("Pushing notification: ", _notification, " ", _array);
	with (obj_achievementtracker)
	{
		ds_queue_enqueue(notify_queue, [_notification, _array]);
	}
}

function achievement_add_variable(_name, _value, _save = false, _resettable = false)
{
	var q = 
	{
		init_value: _value,
		value: _value,
		save: _save,
		resettable: _resettable
	};
	ds_map_add(variables, _name, q);
	return q;
}

function achievement_get_variable(_name)
{
	return ds_map_find_value(variables, _name);
}

function achievement_get_all_variables()
{
	var arr = [];
	var key = ds_map_find_first(variables);
	var size = ds_map_size(variables);
	for (var i = 0; i < size; i++)
	{
		array_push(arr, ds_map_find_value(variables, key));
		key = ds_map_find_next(variables, key);
	}
	return arr;
}

function achievement_unlock(_name, _display_name, _spr, _index = 0)
{
	var b = achievement_get_struct(_name);
	with (b)
	{
		if (!unlocked)
		{
			trace("Achievement unlocked! ", _name, " ", _display_name);
			unlocked = true;
			ini_open_from_string(obj_savesystem.ini_str);
			ini_write_real("achievements", name, true);
			obj_savesystem.ini_str = ini_close();
			notification_push(notifications.achievement_unlocked, [name]);
			obj_achievementtracker.alarm[0] = 2;
			ds_queue_enqueue(obj_achievementtracker.unlock_queue, [_spr, _index]);
		}
	}
	scr_steam_unlock_achievement(_name);
	with (obj_achievementviewer)
	{
		event_perform(ev_other, ev_room_start);
	}
}

function scr_steam_unlock_achievement(_achievement)
{
	if (global.steam_api)
	{
		var steamach = ds_map_find_value(global.steam_achievements, _achievement);
		if (!is_undefined(steamach))
		{
			trace("Steam achievement unlocked! ", steamach);
			if (!steam_get_achievement(steamach))
			{
				steam_set_achievement(steamach);
			}
		}
		else
		{
			trace("Could not find steam achievement! ", _achievement);
		}
	}
	else
	{
		trace("Steam API not initialized!");
	}
}

function palette_unlock(_achievement, _palname, _palindex, _texture = noone, _is_peppino = true)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	var _unlocked = ini_read_real("Palettes", _palname, false);
	ini_write_real("Palettes", _palname, true);
	obj_savesystem.ini_str_options = ini_close();
	gamesave_async_save_options();
	var b = achievement_get_struct(_achievement);
	with (b)
	{
		if (!unlocked && !_unlocked)
		{
			unlocked = true;
			with (instance_create(0, 0, obj_cheftask))
			{
				achievement_spr = noone;
				sprite_index = spr_newclothes;
				if (!_is_peppino)
				{
					sprite_index = spr_newclothesN;
					spr_palette = spr_noisepalette;
				}
				paletteselect = _palindex;
				texture = _texture;
			}
		}
		if (_unlocked)
		{
			unlocked = true;
		}
	}
}

function achievement_reset_variables(_achievements)
{
	for (var i = 0; i < array_length(_achievements); i++)
	{
		var b = _achievements[i];
		with (b)
		{
			var size = ds_map_size(variables);
			var key = ds_map_find_first(variables);
			for (var j = 0; j < size; j++)
			{
				var q = ds_map_find_value(variables, key);
				if (q.resettable)
				{
					q.value = q.init_value;
				}
				key = ds_map_find_next(variables, key);
			}
		}
	}
}

function achievement_save_variables(_achievements)
{
	for (var i = 0; i < array_length(_achievements); i++)
	{
		var b = _achievements[i];
		ini_open_from_string(obj_savesystem.ini_str);
		with (b)
		{
			var size = ds_map_size(variables);
			var key = ds_map_find_first(variables);
			for (var j = 0; j < size; j++)
			{
				var q = ds_map_find_value(variables, key);
				if (q.save)
				{
					ini_write_real("achievements_variables", key, q.value);
				}
				key = ds_map_find_next(variables, key);
			}
		}
		obj_savesystem.ini_str = ini_close();
	}
}

function achievement_get_steam_achievements(_achievements)
{
	for (var i = 0; i < array_length(_achievements); i++)
	{
		var b = _achievements[i];
		ini_open_from_string(obj_savesystem.ini_str);
		with (b)
		{
			if (ini_read_real("achievements", name, false))
			{
				scr_steam_unlock_achievement(name);
			}
		}
		obj_savesystem.ini_str = ini_close();
	}
}

function achievements_load(_achievements)
{
	for (var i = 0; i < array_length(_achievements); i++)
	{
		var b = _achievements[i];
		with (b)
		{
			unlocked = ini_read_real("achievements", name, false);
			var size = ds_map_size(variables);
			var key = ds_map_find_first(variables);
			for (var j = 0; j < size; j++)
			{
				var q = ds_map_find_value(variables, key);
				if (q.save)
				{
					q.value = ini_read_real("achievements_variables", key, q.init_value);
				}
				key = ds_map_find_next(variables, key);
			}
		}
	}
}

function achievement_get_struct(_achievement)
{
	var l = obj_achievementtracker.achievements_update;
	var b = noone;
	for (var i = 0; i < array_length(l); i++)
	{
		var q = l[i];
		if (q.name == _achievement)
		{
			b = q;
			break;
		}
	}
	if (b == noone)
	{
		l = obj_achievementtracker.achievements_notify;
		for (var i = 0; i < array_length(l); i++)
		{
			var q = l[i];
			if (q.name == _achievement)
			{
				b = q;
				break;
			}
		}
	}
	return b;
}
