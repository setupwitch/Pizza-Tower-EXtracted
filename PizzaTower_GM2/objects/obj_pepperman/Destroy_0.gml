if (elitehit <= 0 && pizzahead && destroyable)
{
	instance_create_unique(0, 0, obj_viginoiseyspawner);
	with (instance_create_unique(room_width / 4, room_height + 100, obj_vigilanteboss))
	{
		with (obj_bosscontroller)
		{
			boss_hpsprite = spr_bossfight_vigiHP;
			boss_palette = spr_bossfight_vigipalette;
		}
		instance_destroy(spotlightID);
		pizzahead = true;
		flickertime = 0;
		state = states.pizzaheadjump;
		sprite_index = spr_playerV_hurt;
		image_index = 0;
		image_speed = 0.35;
		hsp = 0;
		vsp = -18;
		elitehit = 4;
		prevhp = elitehit;
		destroyable = true;
		
		vigilante_start_attack(0, 5);
		vigilante_add_attack(0, 5, vigilante_attacks.dynamite);
		vigilante_add_attack(0, 5, vigilante_attacks.dynamite);
		vigilante_add_attack(0, 5, vigilante_attacks.wait, 25);
		vigilante_add_attack(0, 5, vigilante_attacks.revolver, 5);
		vigilante_add_attack(0, 5, vigilante_attacks.revolver, 5);
		vigilante_add_attack(0, 5, vigilante_attacks.kick, 20);
		
		vigilante_start_attack(0, 6);
		vigilante_add_attack(0, 6, vigilante_attacks.dynamite);
		vigilante_add_attack(0, 6, vigilante_attacks.dynamite);
		vigilante_add_attack(0, 6, vigilante_attacks.wait, 25);
		vigilante_add_attack(0, 6, vigilante_attacks.revolver, 5);
		vigilante_add_attack(0, 6, vigilante_attacks.revolver, 5);
		vigilante_add_attack(0, 6, vigilante_attacks.kick, 20);
		
		vigilante_start_attack(0, 7);
		vigilante_add_attack(0, 7, vigilante_attacks.bazooka);
		vigilante_add_attack(0, 7, vigilante_attacks.kick, 20);
		vigilante_add_attack(0, 7, vigilante_attacks.uzi);
		vigilante_add_attack(0, 7, vigilante_attacks.flamethrower, 200);
		vigilante_add_attack(0, 7, vigilante_attacks.wait, 25);
		
		vigilante_start_attack(0, 8);
		vigilante_add_attack(0, 8, vigilante_attacks.dynamite);
		vigilante_add_attack(0, 8, vigilante_attacks.dynamite);
		vigilante_add_attack(0, 8, vigilante_attacks.wait, 25);
		vigilante_add_attack(0, 8, vigilante_attacks.dynamite);
		vigilante_add_attack(0, 8, vigilante_attacks.dynamite);
		vigilante_add_attack(0, 8, vigilante_attacks.kick, 20);
		
		vigilante_start_attack(0, 9);
		vigilante_add_attack(0, 9, vigilante_attacks.uzi);
		vigilante_add_attack(0, 9, vigilante_attacks.kick);
		vigilante_add_attack(0, 9, vigilante_attacks.wait, 25);
	}
}
if (destroyable && elitehit <= 0)
{
	scr_pepperman_destroy_sounds();
}
event_inherited();
