enum debug_texttypes
{
	plain = 0,
	command = 1,
	debug_log = 2,
	error = 3,
}

depth = -500;
DEBUG = false;
if (parameter_count() > 2)
{
	DEBUG = true;
}
if (!DEBUG)
{
	var n = parameter_count();
	for (var i = 0; i < n; i++)
	{
		var s = parameter_string(i);
		if (s == "-debug" || s == "debug")
		{
			DEBUG = true;
		}
	}
}
if (!DEBUG)
{
	instance_destroy();
}
if (DEBUG)
{
	active = false;
	showoverlay = false;
	SET_GAME_SPEED = new DebugCommand("set_game_speed", "Sets the game speed", "<int>", function(_int)
	{
		game_set_speed(floor(real(_int)), gamespeed_fps);
	});
	TEST_P_RANK = new DebugCommand("test_p_rank", "", "", function()
	{
		global.collect = global.srank + 5000;
		global.lap = true;
		global.treasure = true;
		global.secretfound = 3;
		global.combodropped = false;
		global.prank_enemykilled = true;
		global.combotime = 60;
		global.combo = 99;
		global.panic = true;
	});
	KILL_BOSS = new DebugCommand("kill_boss", "", "", function()
	{
		instance_destroy(obj_baddie);
	});
	SET_BOSS_HP = new DebugCommand("set_boss_hp", "", "<int>", function(_int)
	{
		with (obj_baddie)
		{
			elitehit = real(_int);
		}
	});
	SWITCH_CHAR = new DebugCommand("switch_char", "Switches character", "", function()
	{
		with (obj_player)
		{
			character = "P";
			ispeppino = !ispeppino;
			scr_characterspr();
		}
	});
	FILL_GATESWITCH = new DebugCommand("gateswitchmax", "", "", function()
	{
		global.gateswitch = global.gateswitchmax;
	});
	SHOW_DEBUG_OVERLAY = new DebugCommand("show_debug_overlay", "Toggles debug overlay", "", function()
	{
		show_debug_overlay(!showoverlay);
		showoverlay = !showoverlay;
	});
	ROOMCHECK = new DebugCommand("roomcheck", "", "", function()
	{
		instance_create_unique(0, 0, obj_roomcheck);
	});
	UNLOCK_TOPPINS = new DebugCommand("unlock_toppins", "Unlocks the toppins of the given level", "<level_name_ini>", function(_level_name_ini)
	{
		if (is_undefined(_level_name_ini))
		{
			exit;
		}
		ini_open_from_string(obj_savesystem.ini_str);
		ini_write_real("Toppin", concat(_level_name_ini, 1), true);
		ini_write_real("Toppin", concat(_level_name_ini, 2), true);
		ini_write_real("Toppin", concat(_level_name_ini, 3), true);
		ini_write_real("Toppin", concat(_level_name_ini, 4), true);
		ini_write_real("Toppin", concat(_level_name_ini, 5), true);
		obj_savesystem.ini_str = ini_close();
		gamesave_async_save();
	});
	UNLOCK_BOSS_KEY = new DebugCommand("unlock_boss_key", "Unlocks the boss key of the given world (1, 2, 3, 4)", "<number>", function(_number)
	{
		if (is_undefined(_number))
		{
			exit;
		}
		_number = real(_number);
		ini_open_from_string(obj_savesystem.ini_str);
		var n = concat("w", _number, "stick");
		ini_write_real(n, "bosskey", true);
		obj_savesystem.ini_str = ini_close();
		gamesave_async_save();
	});
	LOCKCAMERA = new DebugCommand("lockcam", "", "", function()
	{
		with (obj_camera)
		{
			lock = !lock;
		}
	});
	BOSSINVINCIBLE = new DebugCommand("bossinv", "", "", function()
	{
		global.boss_invincible = !global.boss_invincible;
	});
	HIDETILES = new DebugCommand("hidetiles", "", "<bool>", function(_bool)
	{
		if (is_undefined(_bool))
		{
			global.hidetiles = !global.hidetiles;
		}
		else
		{
			global.hidetiles = _bool;
		}
		layer_set_visible("Tiles_BG", !global.hidetiles);
		layer_set_visible("Tiles_BG2", !global.hidetiles);
		layer_set_visible("Tiles_BG3", !global.hidetiles);
		layer_set_visible("Tiles_1", !global.hidetiles);
		layer_set_visible("Tiles_2", !global.hidetiles);
		layer_set_visible("Tiles_3", !global.hidetiles);
		layer_set_visible("Tiles_4", !global.hidetiles);
		layer_set_visible("Tiles_Foreground1", !global.hidetiles);
		layer_set_visible("Tiles_Foreground2", !global.hidetiles);
		layer_set_visible("Tiles_Foreground3", !global.hidetiles);
	});
	THROWARC = new DebugCommand("throwarc", "", "<bool>", function(_bool)
	{
		if (is_undefined(_bool))
		{
			global.throwarc = !global.throwarc;
		}
		else
		{
			global.throwarc = _bool;
		}
	});
	GOTOEDITOR = new DebugCommand("editor", "", "", function()
	{
		with (obj_player)
		{
			targetRoom = editor_room;
			targetDoor = "A";
		}
		instance_create_unique(0, 0, obj_fadeout);
	});
	NOCLIP = new DebugCommand("noclip", "", "", function()
	{
		with (obj_player1)
		{
			state = states.debugstate;
		}
	});
	GIVEKEY = new DebugCommand("givekey", "", "", function()
	{
		global.key_inv = true;
	});
	LOADTEST = new DebugCommand("loadtest", "", "", function()
	{
		with (obj_debugcontroller)
		{
			DoCommand("player_room rm_testing4 A");
			alarm[0] = 20;
		}
	});
	OTHERTEST = new DebugCommand("othertest", "", "", function()
	{
		with (obj_debugcontroller)
		{
			DoCommand("showcollisions 1");
			DoCommand("player_room rm_testing4 A");
			DoCommand("switch_char");
			alarm[0] = 20;
		}
	});
	SETCOMBO = new DebugCommand("set_combo", "Set the combo", "<combo> <combotime:optional>", function(_combo, _combotime)
	{
		if (_combo == undefined)
		{
			exit;
		}
		if (_combotime == undefined)
		{
			_combotime = 60;
		}
		global.combo = real(_combo);
		global.combotime = real(_combotime);
		with (obj_player)
		{
			supercharge = 10;
		}
	});
	GIVEHEAT = new DebugCommand("giveheat", "Gives heat", "", function()
	{
		global.style += 100;
	});
	ALLTOPPINS = new DebugCommand("alltoppins", "Adds all the toppins", "", function()
	{
		if (!instance_exists(obj_pizzakincheese))
		{
			instance_create(obj_player1.x, obj_player1.y, obj_pizzakincheese);
		}
		if (!instance_exists(obj_pizzakintomato))
		{
			instance_create(obj_player1.x, obj_player1.y, obj_pizzakintomato);
		}
		if (!instance_exists(obj_pizzakinsausage))
		{
			instance_create(obj_player1.x, obj_player1.y, obj_pizzakinsausage);
		}
		if (!instance_exists(obj_pizzakinpineapple))
		{
			instance_create(obj_player1.x, obj_player1.y, obj_pizzakinpineapple);
		}
		if (!instance_exists(obj_pizzakinshroom))
		{
			instance_create(obj_player1.x, obj_player1.y, obj_pizzakinshroom);
		}
		global.cheesefollow = true;
		global.tomatofollow = true;
		global.sausagefollow = true;
		global.pineapplefollow = true;
		global.shroomfollow = true;
	});
	PANIC = new DebugCommand("panic", "Toggles pizza time", "<fill>", function(_fill)
	{
		if (_fill != undefined && _fill != "")
		{
			_fill = get_number_string(_fill);
		}
		else
		{
			_fill = 4000;
		}
		global.panic = !global.panic;
		global.fill = _fill;
		if (global.panic)
		{
			obj_camera.alarm[1] = 60;
		}
		obj_tv.chunkmax = global.fill;
	});
	SHOW_COLLISIONS = new DebugCommand("showcollisions", "Shows the collisions", "<bool>", function(_bool)
	{
		if (_bool == undefined)
		{
			exit;
		}
		_bool = get_bool(_bool);
		if (_bool != undefined)
		{
			showcollisions = _bool;
			event_perform(ev_other, ev_room_start);
		}
	});
	SHOW_HUD = new DebugCommand("showhud", "Shows the HUD", "<bool>", function(_bool)
	{
		if (_bool == undefined)
		{
			exit;
		}
		_bool = get_bool(_bool);
		show_debug_message(!_bool);
		if (_bool != undefined)
		{
			showhud = _bool;
			with (obj_tv)
			{
				visible = _bool;
				show_debug_message(visible);
			}
			with (obj_camera)
			{
				visible = _bool;
				show_debug_message(visible);
			}
			with (obj_roomname)
			{
				visible = _bool;
				show_debug_message(visible);
			}
			with (obj_pigtotal)
			{
				visible = _bool;
				show_debug_message(visible);
			}
		}
	});
	PLAYER_ROOM = new DebugCommand("player_room", "Go to given room", "<targetRoom> <targetDoor>", function(_targetRoom, _targetDoor)
	{
		if (_targetRoom == undefined)
		{
			exit;
		}
		if (_targetDoor == undefined)
		{
			exit;
		}
		_targetRoom = asset_get_index(_targetRoom);
		if (_targetRoom == -1)
		{
			exit;
		}
		with (obj_player)
		{
			targetRoom = _targetRoom;
			targetDoor = _targetDoor;
		}
		instance_create(x, y, obj_fadeout);
	});
	CAMERA_ZOOM = new DebugCommand("camera_zoom", "Zoom", "<targetzoom> <spd>", function(_targetzoom, _spd)
	{
		if (_targetzoom == undefined)
		{
			exit;
		}
		if (_spd != undefined)
		{
			_spd = get_number_string(_spd);
		}
		with (obj_camera)
		{
			targetzoom = _targetzoom;
			targetzoom = clamp(targetzoom, 0, max_zoom);
			if (_spd != undefined)
			{
				zoomspd = abs(_spd);
			}
		}
	});
	DESTROYICE = new DebugCommand("destroyice", "", "", function()
	{
		instance_destroy(obj_iceblock);
		instance_destroy(obj_iceblockslope);
	});
	HARDMODE = new DebugCommand("hardmode", "Toggles hardmode", "<bool>", function(_bool)
	{
		if (_bool == undefined)
		{
			exit;
		}
		_bool = get_bool(_bool);
		show_debug_message(!_bool);
		if (_bool != undefined)
		{
			global.hardmode = _bool;
			with (obj_hardmode)
			{
				event_perform(ev_other, ev_room_start);
			}
		}
	});
	PLAYER_SET_STATE = new DebugCommand("player_set_state", "Changes the player state", "<states.state>", function(_state)
	{
		if (_state == undefined)
		{
			exit;
		}
		_state = ds_map_find_value(state_map, _state);
		if (!is_undefined(_state))
		{
			with (obj_player)
			{
				if (object_index == obj_player1 || global.coop)
				{
					state = _state;
					var _spr = sprite_index;
					switch (_state)
					{
						case states.normal:
							_spr = spr_idle;
							break;
						case states.cheesepep:
							_spr = spr_cheesepep_idle;
							break;
						case states.knightpep:
							_spr = spr_knightpepidle;
							break;
						case states.firemouth:
							_spr = spr_firemouth;
							break;
						case states.ratmount:
							_spr = spr_player_ratmountidle;
							break;
					}
					sprite_index = _spr;
					image_index = 0;
				}
			}
		}
	});
	active = false;
	showcollisions = false;
	showhud = true;
	state_map = ds_map_create();
	ds_map_set(state_map, "states.normal", states.normal);
	ds_map_set(state_map, "states.cheesepep", states.cheesepep);
	ds_map_set(state_map, "states.knightpep", states.knightpep);
	ds_map_set(state_map, "states.firemouth", states.firemouth);
	ds_map_set(state_map, "states.ratmount", states.ratmount);
	command_list = ds_list_create();
	ds_list_add(command_list, DESTROYICE, SET_GAME_SPEED, SHOW_HUD, SHOW_COLLISIONS, PLAYER_ROOM, CAMERA_ZOOM, HARDMODE, PLAYER_SET_STATE, PANIC, ALLTOPPINS, GIVEHEAT, ROOMCHECK, SWITCH_CHAR, SET_BOSS_HP);
	ds_list_add(command_list, OTHERTEST, KILL_BOSS, TEST_P_RANK, FILL_GATESWITCH, SETCOMBO, GIVEKEY, LOADTEST, NOCLIP, THROWARC, HIDETILES, LOCKCAMERA, BOSSINVINCIBLE, UNLOCK_TOPPINS, UNLOCK_BOSS_KEY, SHOW_DEBUG_OVERLAY, GOTOEDITOR);
	input_text = "";
	text_list = ds_list_create();
	search_commands = ds_list_create();
	ds_list_clear(search_commands);
	search_w = 0;
	keyboard_string = "";
	
	function FindCommand(_command)
	{
		for (var i = 0; i < ds_list_size(command_list); i++)
		{
			var b = ds_list_find_value(command_list, i);
			if (b.command_id == _command)
			{
				return b;
			}
		}
		return undefined;
	}
	
	function DoCommand(_command)
	{
		var commands = string_split(_command, " ");
		trace(commands);
		if (array_length(commands) > 0)
		{
			var c = FindCommand(commands[0]);
			if (c != undefined)
			{
				TextList_Add(debug_texttypes.command, _command);
				array_delete(commands, 0, 1);
				c.Invoke(commands);
				return true;
			}
			else
			{
				TextList_Add(debug_texttypes.plain, _command);
				TextList_Add(debug_texttypes.error, "Invalid command");
			}
		}
		else
		{
			TextList_Add(debug_texttypes.plain, _command);
			TextList_Add(debug_texttypes.error, "No text typed");
		}
		return false;
	}
	
	function GetDouble(_doublestr)
	{
		var n = string_digits(_doublestr);
		if (n != undefined && n != "")
		{
			n = real(_doublestr);
			return n;
		}
		return undefined;
	}
	
	function get_bool(_boolstr)
	{
		if (_boolstr == "true")
		{
			_boolstr = true;
			return _boolstr;
		}
		else if (_boolstr == "false")
		{
			_boolstr = false;
			return _boolstr;
		}
		else if (is_real(real(string_digits(_boolstr))))
		{
			_boolstr = bool(real(string_digits(_boolstr)));
			return _boolstr;
		}
		return undefined;
	}
	
	function get_number_string(_numberstr)
	{
		var n = _numberstr;
		if (is_string(_numberstr))
		{
			n = real(string_digits(_numberstr));
			if (string_char_at(_numberstr, 1) == "-")
			{
				n = -real(string_digits(_numberstr));
			}
		}
		return n;
	}
}
