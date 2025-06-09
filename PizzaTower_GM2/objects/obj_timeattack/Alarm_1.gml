if (global.timeattack == true && stop == false && !instance_exists(obj_ghostcollectibles))
{
	global.taseconds += 1;
	if (global.collect >= 5 && !instance_exists(obj_ghostcollectibles))
	{
		global.collect -= 5;
	}
	if (global.taseconds > 59)
	{
		global.taseconds = 0;
		global.taminutes += 1;
	}
}
alarm[1] = 60;
