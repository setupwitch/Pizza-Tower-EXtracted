function scr_get_timer_string(_mins, _secs, _do_hours = false)
{
	if (_secs < 10)
	{
		_secs = string_format(_secs, 1, 3);
		_secs = "0" + _secs;
	}
	else
	{
		_secs = string_format(_secs, 2, 3);
	}
	var h;
	if (_do_hours)
	{
		for (h = 0; _mins > 59; h++)
		{
			_mins -= 60;
		}
		if (h < 10)
		{
			h = concat("0", h);
		}
		else
		{
			h = string(h);
		}
	}
	if (_mins < 10)
	{
		_mins = concat("0", _mins);
	}
	else
	{
		_mins = concat(_mins);
	}
	if (_do_hours)
	{
		return concat(h, ":", _mins, ":", _secs);
	}
	return concat(_mins, ":", _secs);
}
