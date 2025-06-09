targetplayer = global.coop ? instance_nearest(x, y, obj_player) : obj_player1;
if (obj_bosscontroller.state == states.arenaintro)
{
	exit;
}
if (hp <= 0 && state != states.arenaround && state != states.fistmatch)
{
	if (!thrown && !destroyable)
	{
		boss_destroy(lastplayerid);
	}
}
image_speed = 0.35;
if (knightbuffer > 0)
{
	knightbuffer--;
}
switch (phase)
{
	case 0:
		normal_func = boss_pizzaface_phase1normal;
		break;
	case 1:
		normal_func = boss_pizzahead_phase2normal;
		break;
	case 2:
		normal_func = boss_pizzahead_phase3normal;
		break;
}
switch (state)
{
	case states.arenaround:
		grav = 0.5;
		break;
	case states.normal:
		grav = 0.5;
		normal_func();
		break;
	case states.ram:
		grav = 0.5;
		boss_pizzaface_ram();
		break;
	case states.moustache:
		grav = 0.5;
		boss_pizzaface_moustache();
		break;
	case states.eyes:
		grav = 0.5;
		boss_pizzaface_eyes();
		break;
	case states.mouth:
		grav = 0.5;
		boss_pizzaface_mouth();
		break;
	case states.nose:
		grav = 0.5;
		boss_pizzaface_nose();
		break;
	case states.phase2transition:
		boss_pizzaface_phase2transition();
		break;
	case states.look:
		boss_pizzahead_look();
		break;
	case states.fishing:
		boss_pizzahead_fishing();
		break;
	case states.bombrun:
		boss_pizzahead_bombrun();
		break;
	case states.npcthrow:
		boss_pizzahead_npcthrow();
		break;
	case states.portraitthrow:
		boss_pizzahead_portraitthrow();
		break;
	case states.enguarde:
		boss_pizzahead_enguarde();
		break;
	case states.sexypicture:
		boss_pizzahead_sexypicture();
		break;
	case states.pullinglevel:
		boss_pizzahead_pullinglevel();
		break;
	case states.eat:
		boss_pizzahead_eat();
		break;
	case states.surprisebox:
		boss_pizzahead_surprisebox();
		break;
	case states.spinningrun:
		boss_pizzahead_spinningrun();
		break;
	case states.spin:
		boss_pizzahead_spinningkick();
		break;
	case states.spinningpunch:
		boss_pizzahead_spinningpunch();
		break;
	case states.groundpunch:
		boss_pizzahead_groundpunch();
		break;
	case states.bigkick:
		boss_pizzahead_bigkick();
		break;
	case states.slamhead:
		boss_pizzahead_slamhead();
		break;
	case states.slamhead2:
		boss_pizzahead_slamhead2();
		break;
	case states.walk:
		grav = 0.5;
		if (grounded)
		{
			state = states.normal;
		}
		invincible = true;
		inv_timer = 2;
		break;
	case states.chainsaw:
		grav = 0.5;
		state_boss_chainsaw();
		break;
	case states.backbreaker:
		grav = 0.5;
		state_boss_taunt();
		invincible = true;
		inv_timer = 2;
		break;
	case states.parry:
		grav = 0.5;
		state_boss_parry();
		invincible = true;
		inv_timer = 2;
		break;
	case states.hit:
		grav = 0.5;
		scr_enemy_hit();
		stunned = 30;
		break;
	case states.stun:
		grav = 0.5;
		state_boss_stun();
		break;
}
if (phase == 0 && state != states.ram)
{
	invincible = true;
}
else
{
	invincible = false;
}
attacking = state == states.ram || state == states.nose || state == states.spin || state == states.spinningpunch || state == states.groundpunch || state == states.slamhead || state == states.slamhead2;
colliding = state != states.ram;
if (phase > 0)
{
	mask_index = spr_pizzahead_giddy;
	stunfallspr = spr_pizzahead_giddy;
	walkspr = spr_pizzahead_giddy;
}
