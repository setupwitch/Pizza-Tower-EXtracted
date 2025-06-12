var _player = other.id;
if (ds_map_empty(player_hurtstates))
{
	exit;
}
if (!attacking)
{
	if (!invincible)
	{
		var s = player_hurtstates[? _player.state];
		if (!is_undefined(s))
		{
			lastplayerid = _player;
			invincible = true;
			inv_timer = inv_max;
			boss_hurt(s, _player);
		}
	}
}
else
{
	var sb = boss_hurtstates[? state];
	if (!is_undefined(sb) && state != states.chainsaw && state != states.stun)
	{
		player_hurt(sb, _player);
		lastplayerid = _player;
	}
}
