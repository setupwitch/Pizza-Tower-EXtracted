if (room == rm_editor)
{
	exit;
}
if (vsp < 12)
{
	vsp += grav;
}
if (inv_frame == true)
{
	image_alpha = 0.5;
}
if (inv_frame == false)
{
	image_alpha = 1;
}
scr_collide();
