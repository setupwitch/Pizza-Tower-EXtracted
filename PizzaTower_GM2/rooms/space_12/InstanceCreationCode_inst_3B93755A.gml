piledriver = true;
active = false;

step = function()
{
	with (obj_player)
	{
		if (place_meeting(x, y, other) && state != states.superslam && state != states.chainsaw)
		{
			other.piledriver = false;
		}
	}
	if (piledriver && !active && !place_meeting(x, y, obj_secretbigblock))
	{
		notification_push(notifications.custom_destructibles_destroyed, [room]);
		active = true;
	}
};
