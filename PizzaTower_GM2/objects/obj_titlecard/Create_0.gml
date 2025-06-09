fadein = false;
fadealpha = 0;
start = false;
loading = false;
group_arr = noone;
title_music = noone;
offload_arr = noone;
depth = -600;
noisehead = [];
noisespots = [];
alarm[1] = 1;
with (obj_gusbrickchase)
{
	fmod_event_instance_stop(snd, true);
}
with (obj_gusbrickfightball)
{
	alarm[1] = -1;
}
