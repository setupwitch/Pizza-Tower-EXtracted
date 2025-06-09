if (phase == 0 && attacking)
{
	if (state == states.ram)
	{
		if (other.state == states.backbreaker && other.parry_inst != noone)
		{
			state = states.normal;
			boss_hurt(10, other.id);
			stunned = 50;
			with (other)
			{
				state = states.parry;
				sprite_index = choose(spr_parry1, spr_parry2, spr_parry3);
				image_index = 0;
				image_speed = 0.35;
				taunttimer = 20;
				movespeed = 8;
				parry_inst = noone;
				parry_count = parry_max;
				with (instance_create(x, y, obj_parryeffect))
				{
					image_xscale = other.xscale;
				}
				flash = true;
			}
			parrycount++;
			if (parrycount > 1)
			{
				parrycount = 0;
				if (lostattacks > 0)
				{
					lostattacks--;
					var choseattack = noone;
					var j = 0;
					while (choseattack == noone)
					{
						j = irandom_range(1, array_length(phase1attacks)) - 1;
						choseattack = phase1attacks[j];
					}
					phase1attacks[j] = noone;
					with (instance_create(x, y, obj_pizzafacepart))
					{
						vsp = -11;
						hsp = choose(-5, 5);
						switch (choseattack)
						{
							case states.mouth:
								sprite_index = spr_pizzafaceword;
								break;
							case states.eyes:
								sprite_index = spr_sausageman_idle;
								break;
							case states.nose:
								sprite_index = spr_shroomcollect;
								break;
						}
					}
				}
			}
		}
		else
		{
			state = states.normal;
			player_hurt(20, other.id);
		}
	}
	else
	{
		state = states.normal;
		player_hurt(20, other.id);
	}
}
else if (phase > 0)
{
	event_inherited();
}
