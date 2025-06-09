function toggle_menu_layer(_menulayer)
{
	with (obj_uiparent)
	{
		if (menu_layer == _menulayer)
		{
			active = true;
		}
		else
		{
			active = false;
		}
	}
}
