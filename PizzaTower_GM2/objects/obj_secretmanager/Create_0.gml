if (instance_number(object_index) > 1)
{
	instance_destroy();
	exit;
}
secrettriggers = ds_list_create();
touchall = ds_list_create();
touchrequirement = noone;
init = false;
waittime = 0;
