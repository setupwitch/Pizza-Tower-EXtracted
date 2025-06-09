event_inherited();

boss_array[0] = noone;
boss_array[1] = [obj_pepperman, 1];
boss_array[2] = [obj_vigilanteboss, 1];
boss_array[3] = [obj_noiseboss, 1];
boss_array[4] = [obj_pepperman, 6];
boss_array[5] = [obj_vigilanteboss, 6];
boss_array[6] = [obj_noiseboss, 6];

state = states.arenaround;
attack_pool =
[
	states.mrstick_shield,
	states.mrstick_helicopterhat,
	states.mrstick_panicjump,
	states.jump,
	states.mrstick_smokebombstart,
	states.mrstick_springshoes,
	states.mrstick_cardboard
];

ds_map_set(player_hurtstates, states.handstandjump, 30);
ds_map_set(player_hurtstates, states.chainsawbump, 50);
ds_map_set(player_hurtstates, states.mach2, 20);
ds_map_set(player_hurtstates, states.mach3, 30);
ds_map_set(boss_hurtstates, states.punch, 30);
ds_map_set(boss_hurtstates, states.mrstick_shield, 30);

phase = 1;
max_phase = 7;
max_hp = 500 * max_phase;
hp = max_hp;
stunfallspr = spr_mrstick_hurt;
walkspr = spr_mrstick_idle;
idlespr = spr_mrstick_idle;
spr_dead = spr_mrstick_hurt;
fallspr = spr_mrstick_fall;
bumpspr = spr_mrstick_hurt;
defeatplayerspr = spr_mrstick_idle;
movespeed = 0;
move = 0;
normal_spd = 6;
helicopterspeed = 6;
panicjumpspeed = 12;
shield_buffer = 0;
shield_max = 180;
cardboard_buffer = 0;
cardboard_max = 180;
do_mockery_max = 300;
do_mockery_buffer = do_mockery_max;
mockery_buffer = 0;
mockery_max = 360;
helicopterstate = 0;
helicoptery = y;
warped = false;

attack_max[0] = 40;
attack_max[1] = 40;
attack_max[2] = 40;
attack_max[3] = 40;
attack_max[4] = 40;
attack_max[5] = 40;
attack_max[6] = 40;

attack_cooldown = attack_max[0];
dashcloudid = noone;
targetstunned = 0;

targetstunnedminus[0] = 30;
targetstunnedminus[1] = 30;
targetstunnedminus[2] = 30;
targetstunnedminus[3] = 30;
targetstunnedminus[4] = 30;
targetstunnedminus[5] = 30;
targetstunnedminus[6] = 30;

function boss_destroy(_boss)
{
	SUPER_boss_destroy(_boss);
	targetstunned = 1000;
	stunned = 1000;
	global.mrstickcutscene3 = true;
	quick_ini_write_real(get_savefile_ini(), "cutscene", "mrstick3", true);
}

function boss_hurt(_dmg, _boss)
{
	if (targetstunned > 0)
	{
		targetstunned -= targetstunnedminus[phase - 1];
		attack_cooldown = 0;
		if (targetstunned < 0)
		{
			targetstunned = 1;
		}
	}
	else
	{
		targetstunned = 150;
	}
	SUPER_boss_hurt(_dmg, _boss);
	targetxscale = -_boss.xscale;
}

function boss_hurt_noplayer(_boss)
{
	if (targetstunned > 0)
	{
		targetstunned -= targetstunnedminus[phase - 1];
		attack_cooldown = 0;
		if (targetstunned < 0)
		{
			targetstunned = 1;
		}
	}
	else
	{
		targetstunned = 150;
	}
	SUPER_boss_hurt_noplayer(_boss);
}

function player_hurt(_dmg, _player)
{
	if (!_player.inv_frames && (_player.state != states.backbreaker || _player.parry_inst == noone))
	{
		hitstate = state;
		hithsp = hsp;
		hitvsp = vsp;
		SUPER_player_hurt(_dmg, _player);
		with (_player)
		{
			inv_frames = true;
			alarm[1] = 15;
		}
	}
}
