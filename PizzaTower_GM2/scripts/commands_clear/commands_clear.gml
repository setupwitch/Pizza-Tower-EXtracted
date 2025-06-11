function commands_clear()
{
	for (var i = 0; i < ds_list_size(commands_list); i++)
	{
		commands_list[| i].destroy();
	}
	ds_list_clear(commands_list);
	command_current = 0;
}
