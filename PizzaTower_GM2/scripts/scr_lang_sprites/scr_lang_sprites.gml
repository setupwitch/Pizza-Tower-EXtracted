function lang_sprites_parse(_langname)
{
	var file = file_text_open_read(concat("lang/graphics/", _langname, ".json"));
	var str = "";
	while (!file_text_eof(file))
	{
		str += file_text_readln(file);
		str += "\n";
	}
	file_text_close(file);
	var json = json_parse(str);
	trace(json);
	ds_map_set(global.lang_sprite_map, _langname, ds_map_create());
	var arr = json.sprites;
	for (var i = 0; i < array_length(arr); i++)
	{
		var spr = arr[i];
		var asset = asset_get_index(spr.name);
		if (asset <= -1)
		{
			continue;
		}
		ds_map_set(ds_map_find_value(global.lang_sprite_map, _langname), asset, spr);
		var frame_arr = spr.frames;
		for (var j = 0; j < array_length(frame_arr); j++)
		{
			var frame = frame_arr[j];
			if (ds_list_find_index(global.lang_textures_to_load, frame.texture) == -1)
			{
				ds_list_add(global.lang_textures_to_load, frame.texture);
			}
		}
	}
}

function lang_draw_sprite_ext(_langspr, _image_index, _x, _y, _xscale, _yscale, _rotation, _color, _alpha)
{
	var spr = lang_get_sprite(_langspr);
	if (spr != noone)
	{
		_image_index = floor(_image_index);
		var frame = lang_get_frame(spr, _image_index);
		var texture = lang_get_texture(frame.texture);
		if (texture != noone)
		{
			var w = frame.width;
			var h = frame.height;
			var offset = frame.offset;
			if (w == -1)
			{
				w = sprite_get_width(texture);
			}
			if (h == -1)
			{
				h = sprite_get_height(texture);
			}
			draw_sprite_part_ext(texture, 0, frame.x, frame.y, w, h, _x - offset.x, _y - offset.y, _xscale, _yscale, _color, _alpha);
		}
	}
	else
	{
		draw_sprite_ext(_langspr, _image_index, _x, _y, _xscale, _yscale, _rotation, _color, _alpha);
	}
}

function lang_draw_sprite(_langspr, _image_index, _x, _y)
{
	var color = draw_get_color();
	var alpha = draw_get_alpha();
	lang_draw_sprite_ext(_langspr, _image_index, _x, _y, 1, 1, 0, color, alpha);
}

function lang_get_sprite(_sprname)
{
	if (lang_get_value("custom_graphics"))
	{
		var g = ds_map_find_value(ds_map_find_value(global.lang_sprite_map, global.lang), _sprname);
		if (!is_undefined(g))
		{
			return g;
		}
	}
	return noone;
}

function lang_get_frame(_spritedata, _frame)
{
	if (_spritedata == noone || array_length(_spritedata.frames) == 0)
	{
		return noone;
	}
	_frame = floor(_frame);
	_frame %= array_length(_spritedata.frames);
	if (_frame < 0)
	{
		_frame = 0;
	}
	if (_frame > (array_length(_spritedata.frames) - 1))
	{
		_frame = array_length(_spritedata.frames) - 1;
	}
	return _spritedata.frames[_frame];
}

function lang_get_texture(_langname)
{
	var g = ds_map_find_value(global.lang_texture_map, _langname);
	if (!is_undefined(g))
	{
		return g;
	}
	return noone;
}
