if (parryable && other.state == states.backbreaker && other.parry_inst != noone)
{
	exit;
}
player_hurt(dmg, other.id);
