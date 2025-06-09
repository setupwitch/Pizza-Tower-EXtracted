if (!place_meeting(x, y + 1, obj_solid) && vsp > 0 && hit == false)
{
	falling = true;
}
if (place_meeting(x, y + 1, obj_solid) && falling == true)
{
	falling = false;
}
if (!place_meeting(x, y, obj_noisetrap_rock))
{
	hsp = 0;
}
if (falling == true && hit == false)
{
	hsp = 0;
}
scr_collide();
