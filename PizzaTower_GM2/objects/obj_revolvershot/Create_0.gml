event_inherited();
dmg = 30;
spd = 25;
parryable = true;

function player_hurt(_dmg, _player)
{
	if (!collisioned)
	{
		var prevstate = _player.state;
		SUPER_player_hurt(_dmg, _player);
		_player.xscale = -image_xscale;
		_player.hitxscale = -image_xscale;
		if (prevstate == states.superattack)
		{
			_player.hithsp = 0;
			_player.hitvsp = 0;
			_player.hitstate = states.superattack;
			with (obj_vigilanteboss)
			{
				duel_buffer = duel_max + irandom(duel_random);
			}
		}
	}
}

function parry()
{
	var prevparried = parried;
	SUPER_parry();
	if (prevparried != parried)
	{
		image_xscale *= -1;
		dmg = 100;
		spd = 30;
	}
}
