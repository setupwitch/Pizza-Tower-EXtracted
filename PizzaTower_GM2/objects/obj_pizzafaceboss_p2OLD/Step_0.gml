wastedhits = maxhp - hp;
targetplayer = obj_player1;
image_speed = 0.35;
switch (state)
{
	case states.fall:
		scr_pizzaface_p2_fall();
		break;
	case states.normal:
		scr_pizzaface_p2_normal();
		break;
	case states.look:
		scr_pizzaface_p2_look();
		break;
	case states.fishing:
		scr_pizzaface_p2_fishing();
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
}
if (place_meeting(x, y, obj_canonexplosion))
{
	if (!explosionhit)
	{
		explosionhit = true;
		hp--;
	}
}
else
{
	explosionhit = false;
}
if (hp <= 0 && !instance_exists(obj_fadeout))
{
	with (obj_player)
	{
		targetRoom = boss_pizzaface_p3;
		targetDoor = "A";
	}
	instance_create(0, 0, obj_fadeout);
}
scr_collide();
