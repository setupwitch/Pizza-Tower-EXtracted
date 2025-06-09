enum optiontypes
{
	toggle = 0,
	multiple = 1,
	press = 2,
	slide = 3,
}

depth = -99;
scr_init_input();
slidecount = 0;
slidebuffer = 0;
bg_alpha = [1, 0, 0, 0, 0];
bg_x = 0;
bg_y = 0;
menus = [];
lastmenu = 0;
menu = 0;
optionselected = 0;
backbuffer = 0;
pause_icons = array_create(0);
scr_pauseicon_add(spr_pauseicons, 4);
scr_pauseicon_add(spr_pauseicons, 5);
scr_pauseicon_add(spr_pauseicons, 6);
scr_pauseicon_add(spr_pauseicons, 7, 8, 8);
var categories = create_menu_fixed(menuids.categories, menuanchors.center, 0, 48, noone);
add_option_press(categories, 0, "option_audio", function()
{
	menu_goto(menuids.audio);
});
add_option_press(categories, 1, "option_video", function()
{
	menu_goto(menuids.video);
});
add_option_press(categories, 2, "option_game", function()
{
	menu_goto(menuids.game);
});
add_option_press(categories, 3, "option_controls", function()
{
	menu_goto(menuids.controls);
});
array_push(menus, categories);
var audio_menu = create_menu_fixed(menuids.audio, menuanchors.left, 150, 40);
add_option_press(audio_menu, 0, "option_back", function()
{
	menu_goto(menuids.categories);
	fmod_event_instance_stop(global.snd_slidermaster, true);
	fmod_event_instance_stop(global.snd_slidermusic, true);
	fmod_event_instance_stop(global.snd_slidersfx, true);
	set_audio_config();
});
add_option_slide(audio_menu, 1, "option_master", function(_volume)
{
	global.option_master_volume = _volume / 100;
	set_audio_config(false);
}, function(_volume)
{
	global.option_master_volume = _volume / 100;
	set_audio_config();
}, "event:/sfx/ui/slidersfxmaster").value = global.option_master_volume * 100;
add_option_slide(audio_menu, 2, "option_music", function(_volume)
{
	global.option_music_volume = _volume / 100;
	set_audio_config(false);
}, function(_volume)
{
	global.option_music_volume = _volume / 100;
	set_audio_config();
}, "event:/sfx/ui/slidermusic").value = global.option_music_volume * 100;
add_option_slide(audio_menu, 3, "option_sfx", function(_volume)
{
	global.option_sfx_volume = _volume / 100;
	set_audio_config(false);
}, function(_volume)
{
	global.option_sfx_volume = _volume / 100;
	set_audio_config();
}, "event:/sfx/ui/slidersfx").value = global.option_sfx_volume * 100;
add_option_toggle(audio_menu, 4, "option_unfocus", function(_unfocus)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "unfocus_mute", _unfocus);
	obj_savesystem.ini_str_options = ini_close();
	global.option_unfocus_mute = _unfocus;
}).value = global.option_unfocus_mute;
array_push(menus, audio_menu);
var video_menu = create_menu_fixed(menuids.video, menuanchors.left, 150, 40);
add_option_press(video_menu, 0, "option_back", function()
{
	menu_goto(menuids.categories);
});
if (!steam_utils_is_steam_running_on_steam_deck())
{
	add_option_press(video_menu, 1, "option_window_mode", function()
	{
		menu_goto(menuids.window);
	});
	var res = [];
	for (var i = 0; i < array_length(global.resolutions[obj_screensizer.aspect_ratio]); i++)
	{
		var b = global.resolutions[obj_screensizer.aspect_ratio][i];
		array_push(res, create_option_value(concat(b[0], "X", b[1]), i, false));
	}
	add_option_multiple(video_menu, 2, "option_resolution", res, function(_resolution)
	{
		ini_open_from_string(obj_savesystem.ini_str_options);
		ini_write_real("Option", "resolution", _resolution);
		obj_savesystem.ini_str_options = ini_close();
		global.option_resolution = _resolution;
		screen_apply_size();
	}).value = global.option_resolution;
}
add_option_toggle(video_menu, 3, "option_vsync", function(_vsync)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "vsync", _vsync);
	obj_savesystem.ini_str_options = ini_close();
	global.option_vsync = _vsync;
	screen_apply_vsync();
}).value = global.option_vsync;
add_option_toggle(video_menu, 4, "option_texfilter", function(_texfilter)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "texfilter", _texfilter);
	obj_savesystem.ini_str_options = ini_close();
	global.option_texfilter = _texfilter;
}).value = global.option_texfilter;
add_option_toggle(video_menu, 5, "option_hud", function(_hud)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "hud", _hud);
	obj_savesystem.ini_str_options = ini_close();
	global.option_hud = _hud;
}).value = global.option_hud;
array_push(menus, video_menu);
var window_menu = create_menu_fixed(menuids.window, menuanchors.left, 150, 40, menuids.video);
add_option_press(window_menu, 0, "option_back", function()
{
	menu_goto(menuids.video);
});
add_option_press(window_menu, 1, "option_windowed", function()
{
	screen_option_apply_fullscreen(0);
	screen_apply_size_delayed();
});
add_option_press(window_menu, 2, "option_fullscreen", function()
{
	screen_option_apply_fullscreen(1);
	screen_apply_size_delayed();
});
add_option_press(window_menu, 3, "option_borderless", function()
{
	screen_option_apply_fullscreen(2);
	screen_apply_size_delayed();
});
array_push(menus, window_menu);
var resolution_menu = create_menu_fixed(menuids.resolution, menuanchors.left, 150, 40, menuids.video);
add_option_press(resolution_menu, 0, "option_back", function()
{
	menu_goto(menuids.video);
});
for (var i = 0; i < array_length(global.resolutions[obj_screensizer.aspect_ratio]); i++)
{
	var b = global.resolutions[obj_screensizer.aspect_ratio][i];
	add_option_press(resolution_menu, i + 1, concat(b[0], "X", b[1]), function()
	{
		var opt = global.option_resolution;
		global.option_resolution = menus[menu].options[optionselected].option_id - 1;
		screen_apply_size();
		with (instance_create(0, 0, obj_screenconfirm))
		{
			savedoption = opt;
			section = "Option";
			key = "resolution";
			varname = "option_resolution";
			depth = obj_option.depth - 1;
		}
	}).localization = false;
}
array_push(menus, resolution_menu);
var game_menu = create_menu_fixed(menuids.game, menuanchors.left, 150, 40);
add_option_press(game_menu, 0, "option_back", function()
{
	menu_goto(menuids.categories);
});
if (room == Mainmenu)
{
	add_option_press(game_menu, 1, "option_lang", function()
	{
		obj_option.key_jump = false;
		instance_create_unique(0, 0, obj_langselect);
	});
}
add_option_toggle(game_menu, 2, "option_vibration", function(_vibration)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "vibration", _vibration);
	obj_savesystem.ini_str_options = ini_close();
	global.option_vibration = _vibration;
}).value = global.option_vibration;
add_option_toggle(game_menu, 3, "option_screenshake", function(_screenshake)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "screenshake", _screenshake);
	obj_savesystem.ini_str_options = ini_close();
	global.option_screenshake = _screenshake;
}).value = global.option_screenshake;
add_option_toggle(game_menu, 4, "option_timer", function(_timer)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "timer", _timer);
	obj_savesystem.ini_str_options = ini_close();
	global.option_timer = _timer;
}).value = global.option_timer;
add_option_multiple(game_menu, 5, "option_timer_type", [create_option_value("option_timer_level", 0), create_option_value("option_timer_save", 1), create_option_value("option_timer_levelsave", 2)], function(_type)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "timer_type", _type);
	obj_savesystem.ini_str_options = ini_close();
	global.option_timer_type = _type;
}).value = global.option_timer_type;
add_option_toggle(game_menu, 6, "option_timer_speedrun", function(_speedrun)
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_write_real("Option", "speedrun_timer", _speedrun);
	obj_savesystem.ini_str_options = ini_close();
	global.option_speedrun_timer = _speedrun;
}).value = global.option_speedrun_timer;
array_push(menus, game_menu);
var controls_menu = create_menu_fixed(menuids.controls, menuanchors.left, 150, 40);
add_option_press(controls_menu, 0, "option_back", function()
{
	menu_goto(menuids.categories);
});
add_option_press(controls_menu, 1, "option_keyboard", function()
{
	menu_goto(menuids.keyboard);
});
add_option_press(controls_menu, 2, "option_controller", function()
{
	menu_goto(menuids.controller);
});
add_option_press(controls_menu, 3, "option_reset_config", function()
{
	ini_open_from_string(obj_savesystem.ini_str_options);
	ini_section_delete("Input");
	ini_section_delete("InputConfig");
	scr_initinput(false);
	obj_savesystem.ini_str_options = ini_close();
	with (obj_option)
	{
		for (var i = 0; i < array_length(menus); i++)
		{
			var b = menus[i];
			if (b.menu_id == menuids.controller || b.menu_id == menuids.deadzones || b.menu_id == menuids.keyboard)
			{
				for (var j = 0; j < array_length(b.options); j++)
				{
					var q = b.options[j];
					if (q.name == "option_deadzone")
					{
						q.value = global.input_controller_deadzone * 100;
					}
					else if (q.name == "option_deadzone_h")
					{
						q.value = global.input_controller_deadzone_horizontal * 100;
					}
					else if (q.name == "option_deadzone_v")
					{
						q.value = global.input_controller_deadzone_vertical * 100;
					}
					else if (q.name == "option_deadzone_press")
					{
						q.value = global.input_controller_deadzone_press * 100;
					}
					else if (q.name == "option_deadzone_superjump")
					{
						q.value = global.gamepad_deadzone_superjump * 100;
					}
					else if (q.name == "option_deadzone_crouch")
					{
						q.value = global.gamepad_deadzone_crouch * 100;
					}
					else if (q.name == "option_controller_superjump")
					{
						q.value = global.gamepad_superjump;
					}
					else if (q.name == "option_controller_groundpound")
					{
						q.value = global.gamepad_groundpound;
					}
					else if (q.name == "option_keyboard_superjump")
					{
						q.value = global.keyboard_superjump;
					}
					else if (q.name == "option_keyboard_groundpound")
					{
						q.value = global.keyboard_groundpound;
					}
				}
			}
		}
	}
	with (create_transformation_tip(lang_get_value("option_controls_resetted")))
	{
		depth = -700;
		alarm[1] = 100;
	}
});
array_push(menus, controls_menu);
var keyboard_menu = create_menu_fixed(menuids.keyboard, menuanchors.left, 150, 40, menuids.controls);
add_option_press(keyboard_menu, 0, "option_back", function()
{
	menu_goto(menuids.controls);
});
add_option_press(keyboard_menu, 1, "option_controller_binds", function(_key)
{
	obj_option.key_jump = false;
	instance_create_unique(0, 0, obj_keyconfig);
});
add_option_toggle(keyboard_menu, 2, "option_keyboard_superjump", function(_key)
{
	global.keyboard_superjump = _key;
	set_controller_config();
}).value = global.keyboard_superjump;
add_option_toggle(keyboard_menu, 3, "option_keyboard_groundpound", function(_key)
{
	global.keyboard_groundpound = _key;
	set_controller_config();
}).value = global.keyboard_groundpound;
array_push(menus, keyboard_menu);
var controller_menu = create_menu_fixed(menuids.controller, menuanchors.left, 150, 40, menuids.controls);
add_option_press(controller_menu, 0, "option_back", function()
{
	menu_goto(menuids.controls);
});
add_option_press(controller_menu, 1, "option_controller_binds", function(_key)
{
	obj_option.key_jump = false;
	with (instance_create_unique(0, 0, obj_keyconfig))
	{
		controller = true;
	}
});
add_option_press(controller_menu, 2, "option_deadzone_title", function(_key)
{
	menu_goto(menuids.deadzones);
});
add_option_toggle(controller_menu, 3, "option_controller_superjump", function(_gpbutton)
{
	global.gamepad_superjump = _gpbutton;
	set_controller_config();
}).value = global.gamepad_superjump;
add_option_toggle(controller_menu, 4, "option_controller_groundpound", function(_gpbutton)
{
	global.gamepad_groundpound = _gpbutton;
	set_controller_config();
}).value = global.gamepad_groundpound;
array_push(menus, controller_menu);
var back = menuids.controller;
var deadzones_menu = create_menu_fixed(menuids.deadzones, menuanchors.left, 150, 40, back);
add_option_press(deadzones_menu, 0, "option_back", function()
{
	menu_goto(menuids.controller);
});
add_option_slide(deadzones_menu, 1, "option_deadzone", function(_deadzone)
{
	if (_deadzone > 90)
	{
		_deadzone = 90;
	}
	global.input_controller_deadzone = _deadzone / 100;
	trace(_deadzone / 100);
	set_controller_config();
}).value = global.input_controller_deadzone * 100;
add_option_slide(deadzones_menu, 2, "option_deadzone_h", function(_deadzone)
{
	if (_deadzone > 90)
	{
		_deadzone = 90;
	}
	global.input_controller_deadzone_horizontal = _deadzone / 100;
	trace(_deadzone / 100);
	set_controller_config();
}).value = global.input_controller_deadzone_horizontal * 100;
add_option_slide(deadzones_menu, 3, "option_deadzone_v", function(_deadzone)
{
	if (_deadzone > 90)
	{
		_deadzone = 90;
	}
	global.input_controller_deadzone_vertical = _deadzone / 100;
	trace(_deadzone / 100);
	set_controller_config();
}).value = global.input_controller_deadzone_vertical * 100;
add_option_slide(deadzones_menu, 4, "option_deadzone_press", function(_deadzone)
{
	if (_deadzone > 90)
	{
		_deadzone = 90;
	}
	global.input_controller_deadzone_press = _deadzone / 100;
	trace(_deadzone / 100);
	set_controller_config();
}).value = global.input_controller_deadzone_press * 100;
add_option_slide(deadzones_menu, 5, "option_deadzone_superjump", function(_deadzone)
{
	global.gamepad_deadzone_superjump = _deadzone / 100;
	set_controller_config();
	trace(_deadzone / 100);
}).value = global.gamepad_deadzone_superjump * 100;
add_option_slide(deadzones_menu, 5, "option_deadzone_crouch", function(_deadzone)
{
	global.gamepad_deadzone_crouch = _deadzone / 100;
	set_controller_config();
	trace(_deadzone / 100);
}).value = global.gamepad_deadzone_crouch * 100;
array_push(menus, deadzones_menu);
