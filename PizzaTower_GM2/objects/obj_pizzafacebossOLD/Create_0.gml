event_inherited();
ds_map_set(player_hurtstates, states.handstandjump, 30);
ds_map_set(player_hurtstates, states.chainsawbump, 50);
ds_map_set(player_hurtstates, states.mach2, 20);
ds_map_set(player_hurtstates, states.mach3, 30);
ds_map_set(player_hurtstates, states.knightpep, 60);
ds_map_set(boss_hurtstates, states.spin, 60);
ds_map_set(boss_hurtstates, states.spinningpunch, 50);
ds_map_set(boss_hurtstates, states.groundpunch, 50);
ds_map_set(boss_hurtstates, states.slamhead, 50);
ds_map_set(boss_hurtstates, states.slamhead2, 50);
hitlist = ds_list_create();
image_speed = 0.35;
max_hp = 3600;
hp = max_hp;
shot = false;
phase = 0;
has_attacked = false;
floatdir = 1;
attackbuffermax = 180;
attackbuffer = attackbuffermax;
phase1attacks = [states.moustache, states.eyes, states.mouth, states.nose];
lostattacks = array_length(phase1attacks);
parrycount = 0;
transitionstate = 0;
bombtimer = 0;
hasbomb = false;
bombgrabID = noone;
knightbuffer = 0;
spawnpool = [obj_forknight, obj_cheeseslime];
hitplayer = false;

function player_hurt(_dmg, _player)
{
	var _prevstate = state;
	if (phase < 2)
	{
		SUPER_player_hurt(_dmg, _player);
	}
	else if ((_player.state != states.backbreaker || _player.parry_inst == noone) && _player.state != states.parry && ds_list_find_index(hitlist, _player) == -1)
	{
		ds_list_add(hitlist, _player);
		SUPER_player_hurt(_dmg, _player);
		state = _prevstate;
		hitplayer = true;
	}
}

function boss_hurt(_dmg, _boss)
{
	if (phase == 0)
	{
		SUPER_boss_hurt(_dmg, _boss);
	}
	else
	{
		var _removehp = true;
		with (_boss)
		{
			if (state != states.lungeattack && state != states.knightpep)
			{
				scr_pummel();
			}
			else if (state == states.knightpep && vsp > 0 && y < (other.y - 30))
			{
				sprite_index = spr_knightpep_doublejump;
				image_index = 0;
				vsp = -11;
				movespeed = 6;
			}
			else if (state != states.lungeattack && state != states.parry)
			{
				_removehp = false;
			}
			if (state == states.lungeattack)
			{
				movespeed = 4;
			}
		}
		if (_removehp)
		{
			hp -= _dmg;
		}
	}
}

function boss_hurt_noplayer(_dmg)
{
	if (inv_timer <= 0)
	{
		hp -= _dmg;
		inv_timer = 10;
	}
}
