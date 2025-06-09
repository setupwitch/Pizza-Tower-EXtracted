if (fallbuffer > 0)
{
	fallbuffer--;
}
else
{
	fall = true;
}
if (fall == false)
{
	y = Approach(y, 32, 2);
}
if (fall == true)
{
	y += 9;
}
if (place_meeting(x, y + 1, obj_solid) && fall == true)
{
	fmod_event_one_shot_3d("event:/sfx/pepperman/statuedestroy", x, y);
	destroy = true;
	instance_destroy();
}
