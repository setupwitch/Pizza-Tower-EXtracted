image_xscale += 0.2;
image_yscale += 0.2;
if (image_xscale > 5 && IS_WINDOWS)
{
	game_end();
}
if (image_xscale > 8)
{
	with (obj_mainmenu)
	{
		jumpscarecount = 0;
	}
	instance_destroy();
}
