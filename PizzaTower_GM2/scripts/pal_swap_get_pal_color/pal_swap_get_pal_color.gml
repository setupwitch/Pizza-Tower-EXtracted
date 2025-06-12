function pal_swap_get_pal_color()
{
	var _palettes = global.Pal_Map[? argument[0]];
	var _current_pal = _palettes[| argument[1]];
	return _current_pal[| argument[2]];
}
