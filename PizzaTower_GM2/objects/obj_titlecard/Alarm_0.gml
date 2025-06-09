loading = true;
with (instance_create(x, y, obj_fadeout))
{
	restarttimer = true;
	if (room == tower_finalhallwaytitlecard)
	{
		finalhallway = true;
	}
}
if (group_arr != noone)
{
	with (instance_create(x, y, obj_loadingscreen))
	{
		offload_arr = other.offload_arr;
		group_arr = other.group_arr;
	}
}
