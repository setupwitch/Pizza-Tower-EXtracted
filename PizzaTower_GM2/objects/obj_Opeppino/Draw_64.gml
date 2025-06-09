draw_sprite(spr_Opeppino, -1, view_get_hport(0) - sprite_get_width(spr_Opeppino), Oy);
if (Oy != (view_get_hport(0) - sprite_get_height(spr_Opeppino)) && up == true)
{
	Oy -= 10;
}
if (up == false)
{
	Oy += 10;
}
