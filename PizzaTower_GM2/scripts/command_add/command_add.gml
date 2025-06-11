function command_add(_command)
{
	with (obj_editor)
	{
		_command.execute();
		while (command_current < ds_list_size(commands_list))
		{
			commands_list[| command_current].destroy();
			ds_list_delete(commands_list, command_current);
		}
		ds_list_add(commands_list, _command);
		command_current++;
	}
}
