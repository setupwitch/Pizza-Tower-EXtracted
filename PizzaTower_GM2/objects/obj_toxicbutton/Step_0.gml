if (active)
{
	with (obj_toxicspray)
	{
		if (trigger == other.trigger && !instance_exists(cloudID))
		{
			cloudID = noone;
			other.active = 0;
		}
	}
}
image_index = active;
