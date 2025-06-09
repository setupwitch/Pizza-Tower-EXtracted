if (x > 1200 && !instance_exists(obj_fadeout) && ok == false)
{
	with (instance_create(x, y, obj_fadeout))
	{
		obj_player.targetRoom = Titlescreen;
	}
}
else if (x > 1200 && ok == true)
{
	instance_destroy();
}
x += 8;
if (room == strongcold_miniboss && x == floor(room_width / 2))
{
	sprite_index = spr_santasleightempty;
	instance_create(x, y, obj_santanoise);
}
if (room == strongcold_miniboss && !instance_exists(obj_presentbox))
{
	instance_destroy();
}
