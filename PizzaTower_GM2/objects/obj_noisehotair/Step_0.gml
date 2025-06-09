if ((obj_player.x > (x - 200) && obj_player.x < (x + 200)) && sprite_index != spr_noisehotairthrow && goingup == false)
{
	sprite_index = spr_noisehotairthrow;
	image_index = 0;
}
if (sprite_index == spr_noisehotairthrow && floor(image_index) == 4 && !instance_exists(obj_noisematch))
{
	instance_create(x - (image_xscale * 10), y, obj_noisematch);
}
if (sprite_index == spr_noisehotairthrow && ANIMATION_END)
{
	sprite_index = spr_noisehotair;
	goingup = true;
}
if (goingup == true)
{
	y -= 5;
}
