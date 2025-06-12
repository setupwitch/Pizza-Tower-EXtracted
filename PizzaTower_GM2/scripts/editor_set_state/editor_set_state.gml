function editor_set_state(_state)
{
	with (obj_editor)
	{
		editor_states[? _state]();
		editor_state = _state;
	}
}
