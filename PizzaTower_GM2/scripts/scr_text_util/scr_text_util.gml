enum button_icons
{
	player_up = 0,
	player_left = 1,
	player_right = 2,
	player_down = 3,
	player_forward = 4,
	player_backward = 5,
	player_slap = 6,
	player_attack = 7,
	player_jump = 8,
	player_shoot = 9,
	player_taunt = 10,
	player_groundpound = 11,
	player_superjump = 12,
	menu_up = 13,
	menu_left = 14,
	menu_right = 15,
	menu_down = 16,
	menu_select = 17,
	menu_back = 18,
	menu_delete = 19,
	menu_quit = 20,
	menu_start = 21,
	menu_reset_binds = 22,
}

function create_transformation_tip(_text, _seenbefore = noone)
{
	ini_open_from_string(obj_savesystem.ini_str);
	if (_seenbefore != noone && ini_read_real("Tip", _seenbefore, false))
	{
		ini_close();
		exit;
	}
	instance_destroy(obj_transfotip);
	var b = noone;
	with (instance_create(0, 0, obj_transfotip))
	{
		text = _text;
		b = id;
	}
	if (_seenbefore != noone)
	{
		ini_write_real("Tip", _seenbefore, true);
	}
	obj_savesystem.ini_str = ini_close();
	return b;
}

function scr_compile_icon_text(_str, _pos = 1, _return_as_array = false)
{
	var arr = [];
	var len = string_length(_str);
	var info = font_get_info(draw_get_font());
	var newline = string_height(lang_get_value("default_letter"));
	var char_x = 0;
	var char_y = 0;
	var offset_x = 0;
	var offset_y = 0;
	if (info.spriteIndex != -1)
	{
		offset_x = sprite_get_xoffset(info.spriteIndex);
		offset_y = sprite_get_yoffset(info.spriteIndex);
	}
	var saved_pos = 1;
	while (_pos <= len)
	{
		var start = _pos;
		var char = string_ord_at(_str, _pos);
		switch (char)
		{
			case ord("\n"):
				char_y += newline;
				char_x = 0;
				break;
			case ord("{"):
				var effect = string_copy(_str, _pos, 3);
				var te = text_effects.shake;
				_pos += 3;
				var n = scr_compile_icon_text(_str, _pos, true);
				switch (effect)
				{
					case "{s}":
						te = text_effects.shake;
						break;
					case "{u}":
						te = text_effects.wave;
						break;
				}
				array_push(arr, [char_x - offset_x, char_y - offset_y, text_types.array, te, n[0]]);
				_pos = n[1];
				char_x = n[2];
				char_y = n[3];
				break;
			case ord("["):
				var button = string_copy(_str, _pos, 3);
				var t = text_types.icon;
				var b = button_icons.player_up;
				switch (button)
				{
					case "[D]":
						b = button_icons.player_down;
						break;
					case "[U]":
						b = button_icons.player_up;
						break;
					case "[M]":
						b = button_icons.player_attack;
						break;
					case "[J]":
						b = button_icons.player_jump;
						break;
					case "[G]":
						b = button_icons.player_slap;
						break;
					case "[F]":
						b = button_icons.player_forward;
						break;
					case "[B]":
						b = button_icons.player_backward;
						break;
					case "[L]":
						b = button_icons.player_left;
						break;
					case "[R]":
						b = button_icons.player_right;
						break;
					case "[S]":
						b = button_icons.player_shoot;
						break;
					case "[T]":
						b = button_icons.player_taunt;
						break;
					case "[g]":
						b = button_icons.player_groundpound;
						break;
					case "[s]":
						b = button_icons.player_superjump;
						break;
					case "[u]":
						b = button_icons.menu_up;
						break;
					case "[d]":
						b = button_icons.menu_down;
						break;
					case "[l]":
						b = button_icons.menu_left;
						break;
					case "[r]":
						b = button_icons.menu_right;
						break;
					case "[c]":
						b = button_icons.menu_select;
						break;
					case "[b]":
						b = button_icons.menu_back;
						break;
					case "[q]":
						b = button_icons.menu_quit;
						break;
					case "[x]":
						b = button_icons.menu_delete;
						break;
					case "[p]":
						b = button_icons.menu_start;
						break;
					case "[y]":
						b = button_icons.menu_reset_binds;
						break;
				}
				array_push(arr, [char_x, char_y, t, b]);
				char_x += 32;
				_pos += 2;
				break;
			case ord("/"):
				if (_return_as_array)
				{
					saved_pos = _pos;
					_pos = len + 1;
				}
				break;
			default:
				while ((_pos + 1) <= len)
				{
					char = string_ord_at(_str, _pos + 1);
					if (char != 91 && char != 10 && char != 123 && char != 47)
					{
						_pos += 1;
					}
					else
					{
						break;
					}
				}
				var n = string_copy(_str, start, (_pos - start) + 1);
				array_push(arr, [char_x - offset_x, char_y - offset_y, text_types.text, n]);
				char_x += string_width(n);
				break;
		}
		_pos += 1;
	}
	if (_return_as_array)
	{
		return [arr, saved_pos, char_x, char_y];
	}
	return arr;
}

function scr_text_arr_size(_array)
{
	var w = 0;
	var newline = string_height(lang_get_value("default_letter"));
	var h = newline;
	for (var i = 0; i < array_length(_array); i++)
	{
		var b = _array[i];
		var cx = b[0];
		var cy = b[1];
		var t = b[2];
		var val = b[3];
		switch (t)
		{
			case text_types.icon:
				if ((cx + 32) > w)
				{
					w += 32;
				}
				break;
			case text_types.array:
				var val2 = b[4];
				var q = scr_text_arr_size(val2);
				if ((cy + q[1]) > h)
				{
					h += (q[1] - newline);
				}
				else if ((cx + q[0]) > w)
				{
					w += q[0];
				}
				break;
			case text_types.text:
				if (cy > h)
				{
					h += newline;
				}
				else
				{
					var sw = string_width(val);
					if ((cx + sw) > w)
					{
						w += string_width(val);
					}
				}
				break;
		}
	}
	return [w, h];
}

function reset_surface_if_resized(_surf, _width, _height)
{
	if (!surface_exists(_surf))
	{
		exit;
	}
	if (surface_get_width(_surf) != _width || surface_get_height(_surf) != _height)
	{
		surface_free(_surf);
	}
}

function scr_draw_granny_texture(_x, _y, _width, _height, _tile_x, _tile_y, _tilespr = spr_pizzagrannytexture, _bubblespr = spr_tutorialbubble)
{
	var w = sprite_get_width(_bubblespr) * _width;
	var h = sprite_get_height(_bubblespr) * _height;
	if (!surface_exists(surfclip))
	{
		surfclip = surface_create(w, h);
	}
	if (!surface_exists(surffinal))
	{
		surffinal = surface_create(w, h);
	}
	surface_set_target(surfclip);
	draw_clear_alpha(c_black, 0);
	draw_rectangle_color(0, 0, w, h, c_white, c_white, c_white, c_white, false);
	gpu_set_blendmode(bm_subtract);
	draw_sprite_ext(_bubblespr, 0, 0, 0, _width, _height, 0, c_white, 1);
	reset_blendmode();
	surface_reset_target();
	surface_set_target(surffinal);
	draw_sprite_tiled(_tilespr, 0, _tile_x, _tile_y);
	gpu_set_blendmode(bm_subtract);
	draw_surface(surfclip, 0, 0);
	reset_blendmode();
	surface_reset_target();
	draw_surface(surffinal, _x, _y);
}

function scr_draw_text_arr(_x, _y, _array, _color = c_white, _alpha = 1, _effect = text_effects.none, _options = noone)
{
	if (_array == noone)
	{
		exit;
	}
	for (var i = 0; i < array_length(_array); i++)
	{
		var b = _array[i];
		var cx = _x + b[0];
		var cy = _y + b[1];
		var t = b[2];
		var val = b[3];
		switch (t)
		{
			case text_types.icon:
				var icon = noone;
				switch (val)
				{
					case button_icons.player_down:
						icon = tdp_get_tutorial_icon("player_down");
						break;
					case button_icons.player_up:
						icon = tdp_get_tutorial_icon("player_up");
						break;
					case button_icons.player_left:
						icon = tdp_get_tutorial_icon("player_left");
						break;
					case button_icons.player_right:
						icon = tdp_get_tutorial_icon("player_right");
						break;
					case button_icons.player_attack:
						icon = tdp_get_tutorial_icon("player_attack");
						break;
					case button_icons.player_jump:
						icon = tdp_get_tutorial_icon("player_jump");
						break;
					case button_icons.player_slap:
						icon = tdp_get_tutorial_icon("player_slap");
						break;
					case button_icons.player_taunt:
						icon = tdp_get_tutorial_icon("player_taunt");
						break;
					case button_icons.player_groundpound:
						if (!global.gamepad_groundpound && obj_inputAssigner.player_input_device[0] >= 0)
						{
							icon = tdp_get_tutorial_icon("player_groundpound");
						}
						else
						{
							icon = tdp_get_tutorial_icon("player_down");
						}
						break;
					case button_icons.player_superjump:
						if (!global.gamepad_superjump && obj_inputAssigner.player_input_device[0] >= 0)
						{
							icon = tdp_get_tutorial_icon("player_superjump");
						}
						else
						{
							icon = tdp_get_tutorial_icon("player_up");
						}
						break;
					case button_icons.player_forward:
						if (instance_exists(obj_player1) && obj_player1.xscale < 0)
						{
							icon = tdp_get_tutorial_icon("player_left");
						}
						else
						{
							icon = tdp_get_tutorial_icon("player_right");
						}
						break;
					case button_icons.player_backward:
						if (instance_exists(obj_player1) && obj_player1.xscale > 0)
						{
							icon = tdp_get_tutorial_icon("player_left");
						}
						else
						{
							icon = tdp_get_tutorial_icon("player_right");
						}
						break;
					case button_icons.menu_left:
						icon = tdp_get_tutorial_icon("menu_left");
						break;
					case button_icons.menu_right:
						icon = tdp_get_tutorial_icon("menu_right");
						break;
					case button_icons.menu_up:
						icon = tdp_get_tutorial_icon("menu_up");
						break;
					case button_icons.menu_down:
						icon = tdp_get_tutorial_icon("menu_down");
						break;
					case button_icons.menu_select:
						icon = tdp_get_tutorial_icon("menu_select");
						break;
					case button_icons.menu_quit:
						icon = tdp_get_tutorial_icon("menu_quit");
						break;
					case button_icons.menu_delete:
						icon = tdp_get_tutorial_icon("menu_delete");
						break;
					case button_icons.menu_back:
						icon = tdp_get_tutorial_icon("menu_back");
						break;
					case button_icons.menu_start:
						icon = tdp_get_tutorial_icon("menu_start");
						break;
					case button_icons.menu_reset_binds:
						icon = tdp_get_tutorial_icon("menu_reset_binds");
						break;
				}
				if (_effect != text_effects.none)
				{
					switch (_effect)
					{
						case text_effects.shake:
							cx += irandom_range(-2, 2);
							cy += irandom_range(-2, 2);
							break;
						case text_effects.wave:
							var o = 1;
							if (_options != noone)
							{
								o = _options.offset;
							}
							var d = ((i % 2) == 0) ? -1 : 1;
							var _dir = floor(Wave(-1, 1, 0.1, 0));
							cy += (_dir * d * o);
							break;
					}
				}
				if (icon != noone)
				{
					draw_sprite(icon.sprite_index, icon.image_index, cx, cy);
					if (icon.str != "")
					{
						var f = draw_get_font();
						draw_set_halign(fa_center);
						draw_set_valign(fa_middle);
						draw_set_font(global.tutorialfont);
						var ox = sprite_get_xoffset(spr_tutorialfont) / 2;
						var oy = sprite_get_yoffset(spr_tutorialfont) / 2;
						draw_text_color((cx + 16) - ox, (cy + 14) - oy, icon.str, c_black, c_black, c_black, c_black, _alpha);
						draw_set_font(f);
						draw_set_halign(fa_left);
						draw_set_valign(fa_top);
					}
				}
				break;
			case text_types.array:
				var val2 = b[4];
				scr_draw_text_arr(cx, cy, val2, _color, _alpha, val);
				break;
			case text_types.text:
				if (_effect == text_effects.none)
				{
					if (!global.tdp_text_try_outline)
					{
						draw_text_color(cx, cy, val, _color, _color, _color, _color, _alpha);
					}
					else
					{
						tdp_draw_text_color(cx, cy, val, _color, _color, _color, _color, _alpha);
					}
				}
				else
				{
					var x2 = 0;
					switch (_effect)
					{
						case text_effects.shake:
							for (var j = 1; j <= string_length(val); j++)
							{
								var q = string_char_at(val, j);
								var s1 = irandom_range(-1, 1);
								var s2 = irandom_range(-1, 1);
								if (!global.tdp_text_try_outline)
								{
									draw_text_color(cx + x2 + s1, cy + s2, q, _color, _color, _color, _color, _alpha);
								}
								else
								{
									tdp_draw_text_color(cx + x2 + s1, cy + s2, q, _color, _color, _color, _color, _alpha);
								}
								x2 += string_width(q);
							}
							break;
						case text_effects.wave:
							for (var j = 1; j <= string_length(val); j++)
							{
								var q = string_char_at(val, j);
								var s = 0;
								var o = 1;
								if (_options != noone)
								{
									o = _options.offset;
								}
								var d = ((j % 2) == 0) ? -1 : 1;
								var _dir = floor(Wave(-1, 1, 0.1, 0));
								s += (_dir * d * o);
								if (!global.tdp_text_try_outline)
								{
									draw_text_color(cx + x2, cy + s, q, _color, _color, _color, _color, _alpha);
								}
								else
								{
									tdp_draw_text_color(cx + x2, cy + s, q, _color, _color, _color, _color, _alpha);
								}
								x2 += string_width(q);
							}
							break;
					}
				}
				break;
		}
	}
}
