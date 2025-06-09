if (ds_list_find_index(global.baddieroom, id) == -1 && important == false)
{
	with (instance_create(x, y, obj_treasureguybox))
	{
		vsp = -3;
		mask_index = other.mask_index;
		for (var i = 0; i < array_length(other.content_arr); i++)
		{
			content_arr[i] = other.content_arr[i];
		}
		current_arr = 0;
		alarm[0] = 30;
	}
}
event_inherited();
