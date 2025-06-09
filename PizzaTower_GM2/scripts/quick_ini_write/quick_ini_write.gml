function quick_ini_write_real(_ini_str, _section, _key, _value)
{
	with (obj_savesystem)
	{
		ini_open_from_string(ini_str);
		ini_write_real(_section, _key, _value);
		ini_str = ini_close();
	}
}
