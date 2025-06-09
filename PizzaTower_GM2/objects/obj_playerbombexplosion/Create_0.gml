image_speed = 0.5;
depth = -1;
hit = false;
has_ended = false;
scr_fmod_soundeffect(global.snd_explosion, x, y);
collision_list = [obj_pizzafaceboss_p2, obj_vigilanteboss, obj_vigilantecow, obj_johnecheese, obj_targetguy];
hitlist = ds_list_create();
hitqueue = ds_queue_create();
collision_function = ds_map_create();
pistol_damage = 4;
destroy = false;

add_hit = function(_inst, _object_index = noone)
{
	if (instance_exists(obj_bossplayerdeath))
	{
		exit;
	}
	if (floor(image_index) > 9)
	{
		exit;
	}
	if (!ds_exists(hitlist, ds_type_list) || !ds_exists(hitqueue, ds_type_queue))
	{
		exit;
	}
	if (ds_list_find_index(hitlist, _inst) == -1)
	{
		if (_object_index == noone)
		{
			ds_queue_enqueue(hitqueue, [_inst, _inst.object_index]);
		}
		else
		{
			ds_queue_enqueue(hitqueue, [_inst, _object_index]);
		}
	}
};

ds_map_set(collision_function, noone, function(arg0)
{
	trace("Non collision, but not misssed");
	return true;
});
ds_map_set(collision_function, obj_baddie, function(_obj)
{
	if (instance_exists(obj_bossplayerdeath))
	{
		return false;
	}
	if (!instance_exists(_obj))
	{
		return false;
	}
	if (_obj.object_index == obj_vigilanteboss || _obj.object_index == obj_pizzafaceboss_p2)
	{
		if (scr_pistolhit(_obj, pistol_damage))
		{
			return true;
		}
		return false;
	}
	if (_obj.object_index == obj_pizzafaceboss && _obj.state == states.ram && _obj.substate == states.land && _obj.elitehit == 1)
	{
		with (instance_create(other.x, other.y, obj_explosioneffect))
		{
			sprite_index = spr_bombexplosion;
		}
		with (_obj)
		{
			scr_boss_do_hurt_phase2(obj_player1.id);
		}
		if (x != other.x)
		{
			image_xscale = sign(other.x - x);
		}
		destroy = true;
		return true;
	}
	if (_obj.object_index == obj_fakepepboss)
	{
		with (_obj)
		{
			if (staggerbuffer <= 0 && flickertime <= 0 && visible && (state == states.walk || (state == states.jump && sprite_index == spr_fakepeppino_bodyslamstart) || (state == states.freefall && sprite_index == spr_fakepeppino_bodyslamland) || (state == states.mach2 && attackspeed < 18) || state == states.Sjumpprep || (state == states.throwing && sprite_index != spr_fakepeppino_flailing)))
			{
				var ix = -other.image_xscale;
				if (x != other.x)
				{
					ix = sign(other.x - x);
				}
				if (subhp > 0)
				{
					if (state == states.walk)
					{
						state = states.staggered;
						image_xscale = ix;
						hsp = -image_xscale * 20;
						vsp = 0;
						sprite_index = spr_fakepeppino_stagger;
						image_index = 0;
					}
					else
					{
						flashbuffer = 9;
					}
					staggerbuffer = 100;
					flash = true;
					subhp--;
					repeat (4)
					{
						create_debris(x, y, spr_slapstar);
					}
				}
				else
				{
					with (obj_fakepephead)
					{
						create_particle(x, y, particletypes.genericpoofeffect);
						instance_destroy(id, false);
					}
					state = states.stun;
					image_xscale = ix;
					hsp = -image_xscale * 8;
					vsp = -6;
					thrown = false;
					linethrown = false;
					sprite_index = spr_fakepeppino_vulnerable;
					stunned = 200;
					flash = true;
					repeat (4)
					{
						create_debris(x, y, spr_slapstar);
					}
				}
				return true;
			}
		}
	}
	if (instance_exists(_obj) && _obj.invtime == 0 && _obj.state != states.grabbed && !_obj.invincible && _obj.instantkillable)
	{
		if (room == boss_pizzaface && (_obj.object_index == obj_pepperman || _obj.object_index == obj_vigilanteboss || _obj.object_index == obj_noiseboss || _obj.object_index == obj_fakepepboss || _obj.object_index == obj_pizzafaceboss_p3))
		{
			other.baddiegrabbedID = _obj;
			with (_obj)
			{
				grabbedby = 1;
				scr_boss_grabbed();
			}
		}
		else
		{
			_obj.invtime = 15;
			fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y);
			if (!_obj.important)
			{
				global.style += (5 + global.combo);
				global.combotime = 60;
				global.heattime = 60;
			}
			var lag = 2;
			_obj.hitLag = lag;
			_obj.hitX = _obj.x;
			_obj.hitY = _obj.y;
			_obj.mach3destroy = true;
			_obj.override_throw = true;
			_obj.hp -= 1;
			instance_create(_obj.x, _obj.y, obj_parryeffect);
			_obj.alarm[3] = 3;
			_obj.state = states.hit;
			if (_obj.x != other.x)
			{
				_obj.image_xscale = sign(other.x - _obj.x);
			}
			else
			{
				_obj.image_xscale = -other.image_xscale;
			}
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_baddiegibs);
			instance_create(x, y, obj_baddiegibs);
			instance_create(x, y, obj_baddiegibs);
			with (obj_camera)
			{
				shake_mag = 3;
				shake_mag_acc = 3 / room_speed;
			}
			_obj.invtime = 30;
			_obj.hitvsp = -4;
			_obj.hithsp = -_obj.image_xscale * 22;
		}
		return true;
	}
	return false;
});
ds_map_set(collision_function, obj_pepper_marbleblock, function(_obj)
{
	with (_obj)
	{
		if (fall && hp > 0)
		{
			scr_sound_multiple("event:/sfx/misc/breakblock", x, y);
			with (other)
			{
				instance_create(x, y, obj_bangeffect);
				if (frac(other.hp) == 0)
				{
					repeat (4)
					{
						create_debris(other.x + random_range(0, 64), other.y + random_range(0, 64), spr_marbledebris);
					}
				}
				repeat (3)
				{
					with (instance_create(x + random_range(0, 64), y + random_range(0, 64), obj_parryeffect))
					{
						sprite_index = spr_deadjohnsmoke;
						image_speed = 0.35;
					}
				}
			}
			with (obj_pepperman)
			{
				if (phase == 2)
				{
					other.hp -= 0.5;
				}
				else
				{
					other.hp -= 1;
				}
			}
			if (hitLag > 0)
			{
				x = hitX;
				y = hitY;
			}
			hitX = x;
			hitY = y;
			hitLag = 10;
			return true;
		}
	}
	return false;
});
ds_map_set(collision_function, obj_peppermanartdude, function(_obj)
{
	instance_destroy(_obj);
	return true;
});
ds_map_set(collision_function, obj_johnecheese, function(_obj)
{
	if (scr_pistolhit(_obj, pistol_damage))
	{
		return true;
	}
	return false;
});
