if (grounded)
{
	hsp = image_xscale * 5;
}
if (drop == true)
{
	if (place_meeting(x, y, obj_player))
	{
		instance_create(x, y, obj_bombexplosion);
		instance_destroy();
	}
	if (place_meeting(x, y, obj_hallway))
	{
		instance_destroy();
	}
	scr_collide();
}
