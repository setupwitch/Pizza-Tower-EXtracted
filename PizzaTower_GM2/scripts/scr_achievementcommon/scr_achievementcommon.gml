function add_secrets_achievement(_secret, _level_array)
{
	var b = add_achievement_notify(concat("secrets", _secret), noone, function(_secret)
	{
		var type = _secret[0];
		if (type == notifications.level_finished)
		{
			var n = levelarray;
			var _unfinished = false;
			ini_open_from_string(obj_savesystem.ini_str);
			for (var i = 0; i < array_length(n); i++)
			{
				var b = n[i];
				var s = ini_read_real("Secret", b, 0);
				if (s < 3)
				{
					_unfinished = true;
				}
			}
			ini_close();
			if (!_unfinished)
			{
				achievement_unlock(name, noone, spr_achievement_farm, 0);
			}
		}
	});
	b.levelarray = _level_array;
}

function add_rank_achievements(_world, _rank, _spr, _index, _level_array)
{
	var b = add_achievement_notify(concat(_rank, "ranks", _world), noone, function(_world)
	{
		var type = _world[0];
		if (type == notifications.level_finished)
		{
			var n = levelarray;
			var _finished = true;
			ini_open_from_string(obj_savesystem.ini_str);
			var map = ds_map_create();
			ds_map_set(map, "d", 0);
			ds_map_set(map, "c", 1);
			ds_map_set(map, "b", 2);
			ds_map_set(map, "a", 3);
			ds_map_set(map, "s", 4);
			ds_map_set(map, "p", 5);
			for (var i = 0; i < array_length(n); i++)
			{
				var b = n[i];
				var s = ini_read_string("Ranks", b, "d");
				if (ds_map_find_value(map, s) < ds_map_find_value(map, rank))
				{
					_finished = false;
				}
			}
			ds_map_destroy(map);
			ini_close();
			if (_finished)
			{
				achievement_unlock(name, "", sprite, index);
			}
		}
	});
	b.rank = _rank;
	b.levelarray = _level_array;
	b.sprite = _spr;
	b.index = _index;
}

function add_boss_achievements(_boss, _bossroom, _spr, _index)
{
	var b = add_achievement_notify(_boss, noone, function(_achievement)
	{
		var type = _achievement[0];
		var arr = _achievement[1];
		if (type == notifications.boss_defeated && arr[0] == bossroom && !global.bossplayerhurt)
		{
			achievement_unlock(name, "", sprite, index);
		}
	});
	b.sprite = _spr;
	b.index = _index;
	b.bossroom = _bossroom;
}

function scr_custom_notification_destructibles()
{
	active = false;
	
	step = function()
	{
		if (!active)
		{
			if (!place_meeting(x, y, obj_destructibles))
			{
				active = true;
				notification_push(notifications.custom_destructibles_destroyed, [room]);
			}
		}
	};
}
