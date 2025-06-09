function scr_sleep(_milliseconds)
{
	var time = current_time;
	var ms = _milliseconds;
	do
	{
	}
	until ((current_time - time) >= round(ms));
	return current_time - time;
}
