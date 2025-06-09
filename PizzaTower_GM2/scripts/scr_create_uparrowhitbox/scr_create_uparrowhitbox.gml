function scr_create_uparrowhitbox()
{
	var b;
	with (instance_create(x, y, obj_uparrowhitbox))
	{
		ID = other.id;
		b = id;
	}
	return b;
}
