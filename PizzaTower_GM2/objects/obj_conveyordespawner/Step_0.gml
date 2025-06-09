for (var i = 0; i < array_length(objectlist); i++)
{
	var b = objectlist[i];
	with (instance_place(x, y, b))
	{
		create_particle(x, y, particletypes.genericpoofeffect);
		instance_destroy();
	}
}
