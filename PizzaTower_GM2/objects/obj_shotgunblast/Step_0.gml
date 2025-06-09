if (floor(image_index) >= 4 && bulletID != noone)
{
	instance_destroy(bulletID);
	bulletID = noone;
}
