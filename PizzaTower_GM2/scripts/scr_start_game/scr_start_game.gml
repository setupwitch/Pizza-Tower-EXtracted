/// @desc - Ran when the game is started, handles what save file to use.
/// @arg {String} _savefile - The save file string to use "N" for noise, "" for peppino.
/// @arg {Bool} _ispeppino - Whether the character is peppino or not.
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
