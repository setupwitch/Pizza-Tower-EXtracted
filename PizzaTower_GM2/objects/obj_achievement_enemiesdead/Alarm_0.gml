var num = instance_place_list(x, y, obj_baddie, global.instancelist, false);
for (var i = 0; i < num; i++)
{
	var b = global.instancelist[| i];
	array_push(baddie_arr, [b, b.object_index]);
}
ds_list_clear(global.instancelist);
