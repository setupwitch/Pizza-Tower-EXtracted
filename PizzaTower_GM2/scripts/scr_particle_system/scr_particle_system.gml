function declare_particle(_particletype, _spr, _spd, _value)
{
	ds_map_set(global.part_map, _particletype, part_type_create());
	ds_map_set(global.part_depth, _particletype, _value);
	var p = ds_map_find_value(global.part_map, _particletype);
	part_type_sprite(p, _spr, true, true, false);
	var t = sprite_get_number(_spr);
	var s = _spd;
	var spd = t / s;
	part_type_life(p, spd, spd);
	return p;
}

function particle_set_scale(_particletype, _xscale, _yscale)
{
	part_type_scale(ds_map_find_value(global.part_map, _particletype), _xscale, _yscale);
}

function create_debris(_x, _y, _spr, _is_animated = false)
{
	var q = 
	{
		x: _x,
		y: _y,
		sprite_index: _spr,
		image_number: sprite_get_number(_spr),
		image_index: irandom(image_number - 1),
		image_angle: random_range(1, 270),
		image_speed: 0.35,
		sprw: sprite_get_width(_spr),
		sprh: sprite_get_height(_spr),
		hsp: random_range(-4, 4),
		vsp: random_range(-5, -2),
		alpha: 1,
		grav: 0.4,
		type: particle_attributes.normal,
		animated: _is_animated,
		destroyonanimation: false
	};
	ds_list_add(global.debris_list, q);
	return q;
}

function create_heatpuff(_x, _y)
{
	var q = instance_create(_x, _y, obj_debris);
	q.sprite_index = spr_heatpuff;
	q.image_index = irandom(sprite_get_number(spr_heatpuff) - 1);
	q.grav = 0;
	q.hsp = 0;
	q.vsp = irandom_range(-4, -1);
	q.image_speed = 0.35;
	q.destroyonanimation = true;
	return q;
}

function create_collect(_x, _y, _spr, _value = 0)
{
	_x -= camera_get_view_x(view_camera[0]);
	_y -= camera_get_view_y(view_camera[0]);
	var q = 
	{
		x: _x,
		y: _y,
		sprite_index: _spr,
		image_index: 0,
		image_number: sprite_get_number(_spr),
		hsp: 0,
		vsp: 0,
		value: _value
	};
	ds_list_add(global.collect_list, q);
	return q;
}

function create_particle(_x, _y, _particletype, _spread = 0)
{
	if (_spread == undefined)
	{
		_spread = 0;
	}
	var _depth = ds_map_find_value(global.part_depth, _particletype);
	if (is_undefined(_depth))
	{
		_depth = object_get_depth(object_index);
	}
	part_system_depth(global.particle_system, _depth);
	part_emitter_region(global.particle_system, global.part_emitter, _x - _spread, _x + _spread, _y - _spread, _y + _spread, 0, 0);
	part_emitter_burst(global.particle_system, global.part_emitter, ds_map_find_value(global.part_map, _particletype), 1);
}
