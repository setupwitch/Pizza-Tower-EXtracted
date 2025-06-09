if (place_meeting(x, y, obj_player) && image_speed == 0)
{
	fmod_event_one_shot_3d("event:/sfx/misc/mine", x, y);
	image_speed = 0.35;
}
if (ANIMATION_END)
{
	instance_destroy();
}
