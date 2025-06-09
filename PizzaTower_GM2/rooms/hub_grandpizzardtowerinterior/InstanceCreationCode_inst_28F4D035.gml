sprite_index = spr_gnome4_idle;
if (global.chateauswap == noone)
{
	global.chateauswap = quick_ini_read_real(get_savefile_ini(), "cutscene", "chateauswap", false);
}
dialog = [dialog_create("Abracadabra", noone, function()
{
	global.chateauswap = !global.chateauswap;
	quick_ini_write_real(get_savefile_ini(), "cutscene", "chateauswap", global.chateauswap);
})];
