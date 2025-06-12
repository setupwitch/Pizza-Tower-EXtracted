function commands_update()
{
	if (key_redo)
	{
		if (command_current < ds_list_size(commands_list))
		{
			var cmd = commands_list[| command_current++];
			cmd.execute();
		}
	}
	if (key_undo)
	{
		if (command_current > 0)
		{
			var cmd = commands_list[| --command_current];
			cmd.undo();
		}
	}
}
