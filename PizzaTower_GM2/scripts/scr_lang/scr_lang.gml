enum langtoken_type
{
	equal = 0,
	identifier = 1,
	string = 2,
	constant = 3,
	end_of_file = 4,
}


function scr_get_languages()
{
	global.lang_map = ds_map_create();
	global.lang_sprite_map = ds_map_create();
	global.lang_texture_map = ds_map_create();
	global.lang_to_load = ds_queue_create();
	global.lang_available = ds_map_create();
	global.lang_loaded = ds_list_create();
	global.lang_tex_max = 0;
	if (!variable_global_exists("lang"))
	{
		global.lang = "en";
	}
	var arr = [];
	var def = file_find_first("lang/*.def", 0);
	while (def != "")
	{
		array_push(arr, def);
		def = file_find_next();
	}
	file_find_close();
	for (var i = 0; i < array_length(arr); i++)
	{
		var str = scr_lang_get_file_arr("lang/" + arr[i]);
		ds_map_set(global.lang_available, array_get(str, 0), 
		{
			name: str[1],
			file: str[2]
		});
	}
	global.credits_arr = scr_lang_get_credits();
	global.noisecredits_arr = scr_lang_get_noise_credits();
	global.lang_textures_to_load = ds_list_create();
	ds_list_add(global.lang_loaded, "en");
	lang_parse_file("english.txt");
}

function lang_read_file(_file)
{
	var fo = file_text_open_read("lang/" + _file);
	var str = "";
	while (!file_text_eof(fo))
	{
		str += file_text_readln(fo);
		str += "\n";
	}
	file_text_close(fo);
	return str;
}

function lang_parse_file(_file)
{
	var str = lang_read_file(_file);
	var key = lang_parse(str);
	if (lang_get_value_raw(key, "custom_graphics"))
	{
		lang_sprites_parse(key);
	}
}

function scr_lang_get_file_arr(_file)
{
	var fo = file_text_open_read(_file);
	var arr = array_create(0);
	while (!file_text_eof(fo))
	{
		array_push(arr, file_text_read_string(fo));
		file_text_readln(fo);
	}
	file_text_close(fo);
	return arr;
}

function scr_lang_get_credits()
{
	return scr_lang_get_file_arr("credits.txt");
}

function scr_lang_get_noise_credits()
{
	var arr = scr_lang_get_file_arr("noisecredits.txt");
	var credits = array_create(0);
	for (var i = 0; i < array_length(arr); i++)
	{
		var _name = arr[i++];
		var _heads = array_create(0);
		var _head = arr[i++];
		while (_head != "")
		{
			array_push(_heads, real(_head) - 1);
			if (i >= array_length(arr))
			{
				break;
			}
			_head = arr[i++];
		}
		i--;
		array_push(credits, 
		{
			name: _name,
			heads: _heads
		});
	}
	return credits;
}

function lang_get_value_raw(_language, _entry)
{
	var n = ds_map_find_value(ds_map_find_value(global.lang_map, _language), _entry);
	if (is_undefined(n))
	{
		n = ds_map_find_value(ds_map_find_value(global.lang_map, "en"), _entry);
	}
	if (is_undefined(n))
	{
		n = "";
		instance_create_unique(0, 0, obj_langerror);
		with (obj_langerror)
		{
			text = concat("Error: Could not find lang value \"", _entry, "\"\nPlease restore your english.txt file");
		}
	}
	return n;
}

function lang_get_value(_entry)
{
	return lang_get_value_raw(global.lang, _entry);
}

function lang_get_value_newline(_entry)
{
	return string_replace_all(lang_get_value(_entry), "\\n", "\n");
}

function lang_get_value_newline_raw(_language, _entry)
{
	return string_replace_all(lang_get_value_raw(_language, _entry), "\\n", "\n");
}

function lang_parse(_str)
{
	var list = ds_list_create();
	lang_lexer(list, _str);
	var map = lang_exec(list);
	var lang = ds_map_find_value(map, "lang");
	ds_map_set(global.lang_map, lang, map);
	ds_list_destroy(list);
	return lang;
}

function lang_lexer(_list, _str)
{
	var len = string_length(_str);
	var pos = 1;
	while (pos <= len)
	{
		var start = pos;
		var char = string_ord_at(_str, pos);
		pos += 1;
		switch (char)
		{
			case ord(" "):
			case ord("	"):
			case ord("\r"):
			case ord("\n"):
				break;
			case ord("#"):
				while (pos <= len)
				{
					char = string_ord_at(_str, pos);
					if (char == ord("\r") || char == ord("\n"))
					{
						break;
					}
					pos += 1;
				}
				break;
			case ord("="):
				ds_list_add(_list, [langtoken_type.equal, start]);
				break;
			case ord("\""):
				while (pos <= len)
				{
					char = string_ord_at(_str, pos);
					if (char != ord("\"") || string_ord_at(_str, pos - 1) == ord("\\"))
					{
						pos += 1;
					}
					else
					{
						break;
					}
				}
				if (pos <= len)
				{
					var val = string_copy(_str, start + 1, pos - start - 1);
					string_replace_all(val, "\\\"", "\"");
					ds_list_add(_list, [langtoken_type.string, start, val]);
					pos += 1;
				}
				else
				{
					exit;
				}
				break;
			default:
				if (lang_get_identifier(char, false))
				{
					while (pos <= len)
					{
						char = string_ord_at(_str, pos);
						if (lang_get_identifier(char, true))
						{
							pos += 1;
						}
						else
						{
							break;
						}
					}
					var name = string_copy(_str, start, pos - start);
					switch (name)
					{
						case "false":
							ds_list_add(_list, [langtoken_type.constant, start, false]);
							break;
						case "noone":
							ds_list_add(_list, [langtoken_type.constant, start, noone]);
							break;
						case "true":
							ds_list_add(_list, [langtoken_type.constant, start, true]);
							break;
						default:
							ds_list_add(_list, [langtoken_type.identifier, start, name]);
					}
				}
				break;
		}
	}
	ds_list_add(_list, [langtoken_type.end_of_file, len + 1]);
}

function lang_get_identifier(_char, _do_numbers)
{
	if (_do_numbers)
	{
		return _char == ord("_") || (_char >= ord("a") && _char <= ord("z")) || (_char >= ord("A") && _char <= ord("Z")) || (_char >= ord("0") && _char <= ord("9"));
	}
	else
	{
		return _char == ord("_") || (_char >= ord("a") && _char <= ord("z")) || (_char >= ord("A") && _char <= ord("Z"));
	}
}

function lang_exec(_list)
{
	var map = ds_map_create();
	var len = ds_list_size(_list);
	var pos = 0;
	while (pos < len)
	{
		var q = ds_list_find_value(_list, pos++);
		switch (q[0])
		{
			case langtoken_type.equal:
				var ident = array_get(ds_list_find_value(_list, pos - 2), 2);
				var val = array_get(ds_list_find_value(_list, pos++), 2);
				ds_map_set(map, ident, val);
				break;
		}
	}
	return map;
}

function lang_get_custom_font(_langfont, _language)
{
	var _dir = concat(_langfont, "_dir");
	var _ttf = ds_map_find_value(_language, "use_ttf");
	if (!is_undefined(_ttf) && _ttf)
	{
		if (!is_undefined(ds_map_find_value(_language, _dir)))
		{
			var font_size = ds_map_find_value(_language, concat(_langfont, "_size"));
			font_size = real(font_size);
			return font_add(concat("lang/", ds_map_find_value(_language, _dir)), font_size, false, false, 32, 127);
		}
	}
	else if (!is_undefined(ds_map_find_value(_language, _dir)))
	{
		var font_map = ds_map_find_value(_language, concat(_langfont, "_map"));
		var font_size = string_length(font_map);
		var font_sep = ds_map_find_value(_language, concat(_langfont, "_sep"));
		font_sep = real(font_sep);
		var font_xorig = 0;
		var font_yorig = 0;
		var spr = sprite_add(concat("lang/", ds_map_find_value(_language, _dir)), font_size, false, false, font_xorig, font_yorig);
		return font_add_sprite_ext(spr, font_map, false, font_sep);
	}
	return lang_get_font(_langfont);
}

function lang_get_font(_langfont)
{
	var n = ds_map_find_value(global.font_map, lang_get_value(_langfont));
	if (!is_undefined(n))
	{
		return n;
	}
	return ds_map_find_value(global.font_map, concat(_langfont, "_en"));
}
