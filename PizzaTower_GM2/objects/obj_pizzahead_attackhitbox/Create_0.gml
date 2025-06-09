event_inherited();
dmg = 30;
parryable = true;

boss_parry_hitbox = function(_player, _hitbox_inst)
{
	if (!_hitbox_inst.collisioned)
	{
		SUPER_parry();
		with (obj_pizzafaceboss)
		{
			SUPER_boss_hurt(30, _player);
		}
		with (_hitbox_inst)
		{
			event_user(0);
		}
	}
};
