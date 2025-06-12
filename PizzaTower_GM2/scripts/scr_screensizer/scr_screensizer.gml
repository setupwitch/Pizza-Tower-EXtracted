/// @desc - Runs screen_apply_size after 1 frame
function screen_apply_size_delayed()
{
	with (obj_screensizer)
	{
		alarm[2] = 1;
	}
}

/// @desc - Updates the screen after a size change.
function screen_apply_size()
{
	with (obj_screensizer)
	{
		if (global.option_resolution == 0 && global.option_scale_mode == 1)
		{
			global.option_resolution = 1;
		}
		if (gameframe_get_fullscreen() == 0)
		{
			gameframe_restore();
		}
		var w = get_resolution_width(global.option_resolution, aspect_ratio);
		var h = get_resolution_height(global.option_resolution, aspect_ratio);
		trace("Setting Window Size: ", w, ", ", h);
		window_set_size(w, h);
		alarm[0] = 2;
	}
}

/// @desc - Applies the vertical synchronization setting
function screen_apply_vsync()
{
	if (room != Loadiingroom)
	{
		trace("Applying VSync: ", global.option_vsync);
		display_reset(0, global.option_vsync);
	}
}

/// @desc - Applies the fullscreen setting in the options menu, creates obj_screenconfirm.
/// @arg {Real} _fullscreen - The fullscreen status
function screen_option_apply_fullscreen(_fullscreen)
{
	var opt = global.option_fullscreen;
	global.option_fullscreen = _fullscreen;
	screen_apply_fullscreen(_fullscreen);
	with (instance_create(0, 0, obj_screenconfirm))
	{
		savedoption = opt;
		section = "Option";
		key = "fullscreen";
		varname = "option_fullscreen";
		depth = obj_option.depth - 1;
	}
}

/// @desc - Applies the fullscreen setting.
/// @arg {Real} - _fullscreen The fullscreen status
function screen_apply_fullscreen(_fullscreen)
{
	if (_fullscreen == 0)
	{
		gameframe_set_fullscreen(0);
		obj_screensizer.alarm[2] = 1;
	}
	else if (_fullscreen == 1)
	{
		gameframe_set_fullscreen(1);
	}
	else if (_fullscreen == 2)
	{
		gameframe_set_fullscreen(2);
	}
}

/// @desc - Resets the surface target, then sets the target to the given surface.
/// @arg {Id.Surface} _surf - The surface to set as the target for drawing.
function surface_safe_set_target(_surf)
{
	surface_reset_target();
	surface_set_target(_surf);
}

/// @desc - Safely resets the draw target, then sets the target to the given surface.
/// @arg {Id.Surface} _surf - The surface to set as the target for drawing.
function set_gui_target(_surf)
{
	while (surface_get_target() != -1 && surface_get_target() != application_surface)
	{
		surface_reset_target();
	}
	surface_set_target(_surf);
}

/// @desc - Safely resets the draw target.
function surface_safe_reset_target()
{
	if (surface_get_target() != -1 && surface_get_target() != application_surface)
	{
		surface_reset_target();
	}
}

/// @desc - Safely resets the draw target, then sets the surface target to obj_screensizer.gui_surf.
function reset_gui_target()
{
	while (surface_get_target() != -1 && surface_get_target() != application_surface)
	{
		surface_reset_target();
	}
	with (obj_screensizer)
	{
		if (!surface_exists(gui_surf))
		{
			exit;
		}
		surface_set_target(gui_surf);
	}
}

/// @desc - Resets the blendmode settings to default.
function reset_blendmode()
{
	gpu_set_blendmode_ext(bm_max, bm_inv_src_alpha);
}

/// @desc - Resets current shader, then re-applies shd_alphafix.
function reset_shader_fix()
{
	if (shader_current() != -1)
	{
		shader_reset();
	}
	shader_set(shd_alphafix);
}

/// @desc - Converts a window X coordinate to the corresponding GUI X coordinate.
/// @arg {Real} _x - The X position in window coordinates to convert.
function window_to_gui_x(_x)
{
	var _win_pos = _x / window_get_width();
	return display_get_gui_width() * _win_pos;
}

/// @desc - Converts a window Y coordinate to the corresponding GUI Y coordinate.
/// @arg {Real} _y - The Y position in window coordinates to convert.
function window_to_gui_y(_y)
{
	var _win_pos = _y / window_get_height();
	return display_get_gui_height() * _win_pos;
}

/// @desc - Calculates the GUI xscale when resizing the window.
/// @arg {Real} _xscale - The xscale of the game
function window_to_gui_xscale(_xscale)
{
	return (_xscale * display_get_gui_width()) / window_get_width();
}

/// @desc - Calculates the GUI yscale when resizing the window.
/// @arg {Real} _yscale - The yscale of the game
function window_to_gui_yscale(_yscale)
{
	return (_yscale * display_get_gui_height()) / window_get_height();
}

/// @desc - Obtains the width of a resolution for a specific aspect ratio.
/// @arg {Real} res - The index of the resolution in the aspect ratio array.
/// @arg {Real} ratio - The aspect ratio to use.
/// @return {Real} - The width of the specified resolution.
function get_resolution_width(_res, _ratio = aspectratios.ratio_16_9)
{
	if (_res < 0 || _res >= array_length(global.resolutions[_ratio]))
	{
		return get_resolution_width(1, _ratio);
	}
	return global.resolutions[_ratio][_res][0];
}

/// @desc - Obtains the height of a resolution for a specific aspect ratio.
/// @arg {Real} res - The index of the resolution in the aspect ratio array.
/// @arg {Real} ratio - The aspect ratio to use.
/// @return {Real} - The height of the specified resolution.
function get_resolution_height(_res, _ratio = aspectratios.ratio_16_9)
{
	if (_res < 0 || _res >= array_length(global.resolutions[_ratio]))
	{
		return get_resolution_height(1, _ratio);
	}
	return global.resolutions[_ratio][_res][1];
}

/// @desc - Obtains the width and height of a resolution for a specific aspect ratio.
/// @arg {Real} res - The index of the resolution in the aspect ratio array.
/// @arg {Real} ratio - The aspect ratio to use.
/// @return {Id.Instance, Array<Real>} - The width and height of the specified resolution.
function get_resolution(_res, _ratio = aspectratios.ratio_16_9)
{
	if (_res < 0 || _res >= array_length(global.resolutions[_ratio]))
	{
		return noone;
	}
	return global.resolutions[_ratio][_res];
}

/// @desc - Clears the screen with the provided color.
/// @arg {Constant.Color} _color - The color to clear the screen with.
function screen_clear(_color = c_black)
{
	draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, _color, _color, _color, _color, false);
}

/// @desc - Sets the global.option_* variables from the save data and handles the language of the OS.
function get_options()
{
	/*ASM
	-	> gml_Script_get_options (locals=4, argc=0)
	+	> gml_Script_get_options (locals=3, argc=0)
	*/
	// im going to assume that the local count issue is due to debug-exclusive lang stuff?
	// if someone knows please correct this.
	
	ini_open("saveData.ini");
	global.option_fullscreen = ini_read_real("Option", "fullscreen", 1);
	global.option_resolution = ini_read_real("Option", "resolution", 1);
	global.option_master_volume = ini_read_real("Option", "master_volume", 1);
	global.option_music_volume = ini_read_real("Option", "music_volume", 0.85);
	global.option_sfx_volume = ini_read_real("Option", "sfx_volume", 1);
	global.option_vibration = ini_read_real("Option", "vibration", 1);
	global.option_scale_mode = ini_read_real("Option", "scale_mode", 0);
	global.option_hud = ini_read_real("Option", "hud", 1);
	global.option_timer = ini_read_real("Option", "timer", 0);
	global.option_speedrun_timer = ini_read_real("Option", "speedrun_timer", 0);
	global.option_timer_type = ini_read_real("Option", "timer_type", 0);
	global.option_unfocus_mute = ini_read_real("Option", "unfocus_mute", 0);
	global.option_texfilter = ini_read_real("Option", "texfilter", 1);
	global.option_vsync = ini_read_real("Option", "vsync", 0);
	
	
	if (IS_DEBUG)
	{
		// artificially inflate variable count
		var _;
		
		// its probably related to something like setting the language
		// e.g:
		/*
		if (keyboard_check_pressed(vk_f9))
		{
			var _chosenlang = get_string();
			quick_ini_write_string("Option", "lang", _chosenlang);
		}
		*/
		// this is just a shot in the dark though.
	}
		
	var lang = ini_read_string("Option", "lang", "none");
	if (lang == "none")
	{
		lang = "en";
		var os_lan = os_get_language();
		switch (os_lan)
		{
			case "zh":
				var region = os_get_region();
				if (region == "HK" || region == "MO" || region == "TW")
				{
					lang = "tc";
				}
				else
				{
					lang = "sc";
				}
				break;
			case "ja": lang = "jp"; break;
			case "fr": lang = "fr"; break;
			case "de": lang = "gr"; break;
			case "it": lang = "it"; break;
			case "pt": lang = "br"; break;
			case "ru": lang = "ru"; break;
			case "es":
				var region = os_get_region();
				if (region == "ES" || region == "ESP")
				{
					lang = "spa";
				}
				else
				{
					lang = "latam";
				}
				break;
		}
		var region = os_get_region();
		if (region == "KR" || region == "KOR")
		{
			lang = "kr";
		}
		global.option_lang = lang;
	}
	else
	{
		global.option_lang = lang;
	}
	global.offload_lang = noone;
	global.option_screenshake = ini_read_real("Option", "screenshake", 1);
	global.lang = global.option_lang;
	if (IS_WINDOWS && steam_utils_is_steam_running_on_steam_deck())
	{
		global.option_fullscreen = 1;
		global.option_resolution = 1;
	}
	ini_close();
	screen_apply_fullscreen(global.option_fullscreen);
	obj_screensizer.start_sound = false;
}
