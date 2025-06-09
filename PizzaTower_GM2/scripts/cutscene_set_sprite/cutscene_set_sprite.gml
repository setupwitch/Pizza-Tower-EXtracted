function cutscene_set_sprite(_inst, _sprite, _speed, _width)
{
	var _obj = _inst;
	var _spr = _sprite;
	var _spd = _speed;
	var _xscale = _width;
	with (_obj)
	{
		sprite_index = _spr;
		image_speed = _spd;
		image_xscale = _xscale;
		image_index = 0;
		xscale = _xscale;
	}
	cutscene_end_action();
}
