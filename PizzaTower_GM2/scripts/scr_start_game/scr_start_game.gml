function scr_start_game(_savefile, _ispeppino = true)
{
	instance_create(x, y, obj_fadeout);
	with (obj_player)
	{
		targetRoom = hub_loadingscreen;
		targetDoor = "A";
	}
	with (obj_savesystem)
	{
		ispeppino = _ispeppino;
	}
	global.currentsavefile = _savefile;
	gamesave_async_load();
}
