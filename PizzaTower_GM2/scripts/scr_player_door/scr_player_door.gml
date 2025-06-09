function scr_player_door()
{
	hsp = 0;
	mach2 = 0;
	jumpAnim = true;
	dashAnim = true;
	landAnim = false;
	moveAnim = true;
	stopAnim = true;
	crouchslideAnim = true;
	crouchAnim = true;
	machhitAnim = false;
	movespeed = 0;
	image_speed = 0.35;
	if (ANIMATION_END)
	{
		image_speed = 0;
		image_index = image_number - 1;
	}
	if (ANIMATION_END && !instance_exists(obj_fadeout) && (sprite_index == spr_downpizzabox || sprite_index == spr_uppizzabox))
	{
		instance_create(x, y, obj_fadeout);
	}
}
