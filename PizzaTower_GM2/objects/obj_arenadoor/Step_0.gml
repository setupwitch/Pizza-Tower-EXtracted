if (sprite_index == spr_arenadoor_open)
{
	if (floor(image_index) == 4 && !shot)
	{
		instance_create(x, y, objectlist[wave][count]);
		shot = true;
	}
	if (ANIMATION_END)
	{
		count++;
		alarm[0] = 10;
		sprite_index = spr_arenadoor;
	}
}
