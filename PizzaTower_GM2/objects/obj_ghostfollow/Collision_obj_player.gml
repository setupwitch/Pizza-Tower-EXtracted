if (!locked && state != states.ghostcaught && other.state != states.door && other.state != states.actor && other.state != states.comingoutdoor)
{
	notification_push(notifications.touched_ghostfollow, [room]);
	with (other)
	{
		hitX = x;
		hitY = y;
		state = states.ghostcaught;
		sprite_index = spr_hurt;
		image_speed = 0.35;
	}
	fmod_event_one_shot("event:/sfx/pep/johnghost");
	fadein = false;
	state = states.ghostcaught;
	playerid = other.id;
}
