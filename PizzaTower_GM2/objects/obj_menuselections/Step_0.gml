if (instance_exists(obj_keyconfig))
{
	visible = false;
}
else
{
	visible = true;
}
ini_open("saveData.ini");
global.key_up = ini_read_string("ControlsKeys", "up", vk_up);
global.key_right = ini_read_string("ControlsKeys", "right", vk_right);
global.key_left = ini_read_string("ControlsKeys", "left", vk_left);
global.key_down = ini_read_string("ControlsKeys", "down", vk_down);
global.key_jump = ini_read_string("ControlsKeys", "jump", ord("Z"));
global.key_slap = ini_read_string("ControlsKeys", "slap", ord("X"));
global.key_shoot = ini_read_string("ControlsKeys", "shoot", ord("C"));
global.key_attack = ini_read_string("ControlsKeys", "attack", vk_shift);
global.key_start = vk_escape;
global.key_upC = ini_read_string("ControllerButton", "up", gp_padu);
global.key_rightC = ini_read_string("ControllerButton", "right", gp_padr);
global.key_leftC = ini_read_string("ControllerButton", "left", gp_padl);
global.key_downC = ini_read_string("ControllerButton", "down", gp_padd);
global.key_jumpC = ini_read_string("ControllerButton", "jump", gp_face1);
global.key_slapC = ini_read_string("ControllerButton", "slap", gp_face3);
global.key_shootC = ini_read_string("ControllerButton", "shoot", gp_face2);
global.key_attackC = ini_read_string("ControllerButton", "attack", gp_shoulderr);
global.key_startC = gp_start;
global.key_upN = ini_read_string("ControlsKeys2", "up", ord("W"));
global.key_rightN = ini_read_string("ControlsKeys2", "right", ord("D"));
global.key_leftN = ini_read_string("ControlsKeys2", "left", ord("A"));
global.key_downN = ini_read_string("ControlsKeys2", "down", ord("S"));
global.key_jumpN = ini_read_string("ControlsKeys2", "jump", ord("L"));
global.key_slapN = ini_read_string("ControlsKeys2", "slap", ord("K"));
global.key_tauntN = ini_read_string("ControlsKeys2", "taunt", ord("O"));
global.key_shootN = ini_read_string("ControlsKeys2", "shoot", ord("I"));
global.key_attackN = ini_read_string("ControlsKeys2", "attack", ord("J"));
global.key_startN = ini_read_string("ControlsKeys2", "start", ord("P"));
global.key_upCN = ini_read_string("ControllerButton", "up", gp_padu);
global.key_rightCN = ini_read_string("ControllerButton", "right", gp_padr);
global.key_leftCN = ini_read_string("ControllerButton", "left", gp_padl);
global.key_downCN = ini_read_string("ControllerButton", "down", gp_padd);
global.key_jumpCN = ini_read_string("ControllerButton", "jump", gp_face1);
global.key_slapCN = ini_read_string("ControllerButton", "slap", gp_face3);
global.key_tauntCN = ini_read_string("ControllerButton", "taunt", gp_face4);
global.key_shootCN = ini_read_string("ControllerButton", "shoot", gp_face2);
global.key_attackCN = ini_read_string("ControllerButton", "attack", gp_shoulderr);
global.key_startCN = ini_read_string("ControllerButton", "start", gp_start);
ini_close();
if (levelselect == true)
{
	if (!instance_exists(obj_keyconfig))
	{
		scr_getinput();
	}
	if (key_down2 && b < 5)
	{
		b += 1;
	}
	if (key_up2 && b > 0)
	{
		b -= 1;
	}
	if (!instance_exists(obj_fadeout))
	{
		if (key_jump)
		{
			with (instance_create(x, y, obj_fadeout))
			{
				if (other.b == 0)
				{
					obj_player.targetRoom = desert_1;
					obj_player.player_x = 208;
					obj_player.player_y = 434;
					obj_player.character = "P";
				}
				if (other.b == 1)
				{
					obj_player.targetRoom = floor2_room0;
					obj_player.player_x = 208;
					obj_player.player_y = 434;
					obj_player.character = "P";
				}
				if (other.b == 2)
				{
					obj_player.targetRoom = floor3_room0;
					obj_player.player_x = 976;
					obj_player.player_y = 434;
					obj_player.character = "P";
				}
				if (other.b == 3)
				{
					obj_player.targetRoom = floor4_room0;
					obj_player.player_x = 304;
					obj_player.player_y = 402;
					obj_player.character = "P";
				}
				if (other.b == 4)
				{
					obj_player.targetRoom = floor5_room1;
					obj_player.player_x = 244;
					obj_player.player_y = 187;
					obj_player.character = "P";
				}
				if (other.b == 5)
				{
					obj_player.targetRoom = golf_room1;
					obj_player.player_x = 176;
					obj_player.player_y = 402;
					obj_player.character = "P";
				}
			}
		}
		if (key_slap2)
		{
			with (instance_create(x, y, obj_fadeout))
			{
				if (other.b == 0)
				{
					obj_player.player_x = 250;
					obj_player.player_y = 250;
					obj_player.character = "P";
				}
				if (other.b == 1)
				{
					obj_player.targetRoom = floor2_roomtreasure;
					obj_player.player_x = 250;
					obj_player.player_y = 250;
					obj_player.character = "P";
				}
			}
		}
	}
}
else if (levelselect == false)
{
	if (!instance_exists(obj_keyconfig))
	{
		scr_getinput();
	}
	if (key_up && !instance_exists(obj_keyconfig) && optionselect == 1)
	{
		optionselect = 0;
	}
	else if (key_down && !instance_exists(obj_keyconfig) && optionselect == 0)
	{
		optionselect = 1;
	}
	if (optionselect == 0)
	{
		obj_cursor.y = y - 24;
	}
	else if (optionselect == 1)
	{
		obj_cursor.y = y + 18;
	}
	if (optionselect == 0 && key_jump && !instance_exists(obj_keyconfig))
	{
		levelselect = true;
		sprite_index = spr_null;
	}
	if (optionselect == 1 && !instance_exists(obj_keyconfig))
	{
		if (keyboard_check_pressed(global.key_jump))
		{
			instance_create(x, y, obj_keyconfig);
		}
		else if (gamepad_button_check_pressed(0, global.key_jumpC))
		{
		}
	}
}
