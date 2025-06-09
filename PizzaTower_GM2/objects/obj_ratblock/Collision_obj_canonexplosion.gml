if (sprite_index != spr_rattumbleblock && other.rat && other.sprite_index != spr_dynamiteexplosion)
{
	if (other.baddie)
	{
		notification_push(notifications.rat_destroyed_with_baddie, [room]);
	}
	instance_destroy();
}
