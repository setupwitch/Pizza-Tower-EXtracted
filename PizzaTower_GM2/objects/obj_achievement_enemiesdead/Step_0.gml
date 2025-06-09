for (var i = 0; i < array_length(baddie_arr); i++)
{
	var b = baddie_arr[i];
	if (b[0] != noone)
	{
		if (!instance_exists(b[0]))
		{
			notification_push(notifications.room_enemiesdead, [b[1], room]);
			baddie_arr[i][0] = noone;
		}
	}
}
