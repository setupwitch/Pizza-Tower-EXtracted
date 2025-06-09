if (!instance_exists(objectID))
{
	instance_destroy();
	exit;
}
x = objectID.x;
y = objectID.y - ypad;
var time, _max;
if (timedgate)
{
	time = global.timedgatetime;
	_max = global.timedgatetimemax;
}
else
{
	var m, s, mm, ms;
	with (obj_deliverytimer)
	{
		m = minutes;
		s = seconds;
		mm = maxminutes;
		ms = maxseconds;
	}
	while (m > 0)
	{
		m--;
		s += 60;
	}
	while (mm > 0)
	{
		mm--;
		ms += 60;
	}
	time = s;
	_max = ms;
}
var p = time / _max;
image_index = round(p * (image_number - 1));
if (!init)
{
	init = true;
	last_index = image_index;
}
else if (last_index != image_index)
{
	if (last_index > image_index)
	{
		fmod_event_one_shot("event:/sfx/misc/timercount");
	}
	else
	{
		fmod_event_one_shot("event:/sfx/misc/timerbegin");
	}
	last_index = image_index;
}
if (timedgate && !global.timedgatetimer)
{
	instance_destroy();
}
