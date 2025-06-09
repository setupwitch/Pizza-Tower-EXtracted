function save_level()
{
	with (obj_editor)
	{
		saved_editor_state = editor_state;
		editor_state = editorstates.save_level;
		save_step = -1;
	}
}
