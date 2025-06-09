function change_room(_room)
{
	if (global.current_level.current_room != _room)
	{
		with (obj_editor)
		{
			commands_clear();
		}
		with (obj_editorobject)
		{
			selected = false;
		}
		with (global.current_level.current_room)
		{
			for (var i = 0; i < array_length(instances); i++)
			{
				instance_deactivate_object(instances[i]);
			}
		}
		with (_room)
		{
			for (var i = 0; i < array_length(instances); i++)
			{
				instance_activate_object(instances[i]);
			}
		}
		camera_set_view_pos(view_camera[0], 0, 0);
		obj_editor.camera_zoom = 1;
		global.current_level.current_room = _room;
	}
}
