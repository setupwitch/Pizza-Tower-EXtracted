if (john && global.panic)
{
	if (room == saloon_4)
	{
		sprite_index = spr_doorblockedsaloon;
	}
	else
	{
		sprite_index = spr_doorblocked;
	}
	if (uparrowID != noone)
	{
		instance_destroy(uparrowID);
		uparrowID = noone;
	}
}
if ((room == tower_5 && targetRoom == tower_pizzafacehall) || room == tower_pizzafacehall)
{
	sprite_index = spr_pizzafacedoor;
}
