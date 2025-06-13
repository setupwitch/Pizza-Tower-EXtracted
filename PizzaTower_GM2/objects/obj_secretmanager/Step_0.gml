for (var i = 0; i < ds_list_size(secrettriggers); i++)
{
	var b = ds_list_find_value(secrettriggers, i);
	if (b[0] != noone)
	{
		method(id, b[0])();
	}
}
