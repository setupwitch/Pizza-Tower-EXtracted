function pattern_set(_colorarray, _spr, _subimg, _xscale, _yscale, _pattern, _is_lang = false)
{
	if (_pattern == noone)
	{
		exit;
	}
	pattern_enable(true);
	pattern_set_pattern(_pattern, 0);
	pattern_set_sprite(_spr, _subimg, _xscale, _yscale, _is_lang);
	pattern_set_color_array(_colorarray);
}
