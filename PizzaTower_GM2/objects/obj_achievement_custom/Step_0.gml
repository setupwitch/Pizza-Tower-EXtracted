var a = active;
if (step != noone)
{
	step();
}
if (a != active)
{
	ds_list_add(global.saveroom, id);
}
