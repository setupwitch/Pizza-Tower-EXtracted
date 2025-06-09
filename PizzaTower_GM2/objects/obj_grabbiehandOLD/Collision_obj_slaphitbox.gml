if (thumbingup == false && (x <= (xstarte + 5) && x >= (xstarte - 5)) && (y <= (ystarte + 5) && y >= (ystarte - 5)) && grabbing == false)
{
	delay = 5;
	image_xscale = -obj_player.xscale;
	thumbingup = true;
	instance_create(x, y, obj_bangeffect);
	sprite_index = spr_grabbiehand_hifive;
	image_index = 0;
}
