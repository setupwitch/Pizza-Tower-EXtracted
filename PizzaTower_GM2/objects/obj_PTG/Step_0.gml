if (distance_to_object(obj_player1) <= 350 || global.level_minutes > timer)
{
	if (global.level_minutes <= timer)
	{
		notification_push(notifications.ptg_seen, [global.leveltosave]);
	}
	instance_destroy();
}
