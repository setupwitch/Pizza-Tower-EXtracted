function editor_set_state(_state)
{
	with (obj_editor)
	{
		ds_map_find_value(editor_states, _state)();
		editor_state = _state;
	}
}
