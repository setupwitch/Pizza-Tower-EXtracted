shot = false;
if (objectlist != noone && count < array_length(objectlist[wave]) && objectlist[wave] != noone)
{
	finish = false;
	shot = false;
	sprite_index = spr_arenadoor_open;
	image_index = 0;
}
else
{
	finish = true;
	count = 0;
}
