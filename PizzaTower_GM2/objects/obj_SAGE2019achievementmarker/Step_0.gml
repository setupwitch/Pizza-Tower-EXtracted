if (picy == 640)
{
	if (snickshotgun == false && global.SAGEshotgunsnick == true)
	{
		up = true;
		sprite = bg_SAGEsnickshotgun;
		snickshotgun = true;
		alarm[0] = 250;
	}
	else if (dungeonbackup == false && global.SAGEdungeonbackup == true)
	{
		up = true;
		sprite = bg_SAGEdungeonbackup;
		dungeonbackup = true;
		alarm[0] = 250;
	}
	else if (srank == false && global.SAGEsrank == true)
	{
		up = true;
		sprite = bg_SAGEsrank;
		srank = true;
		alarm[0] = 250;
	}
	else if (snicksrank == false && global.SAGEsnicksrank == true)
	{
		up = true;
		sprite = bg_SAGEsnicksrank;
		snicksrank = true;
		alarm[0] = 250;
	}
	else if (combo10 == false && global.SAGEcombo10 == true)
	{
		up = true;
		sprite = bg_SAGEcombo10;
		combo10 = true;
		alarm[0] = 250;
	}
	else if (secret == false && global.SAGEsecret == true)
	{
		up = true;
		sprite = bg_SAGEsecret;
		secret = true;
		alarm[0] = 250;
	}
	else if (knight == false && global.SAGEknight == true)
	{
		up = true;
		sprite = bg_SAGEknight;
		knight = true;
		alarm[0] = 250;
	}
	else if (toppin == false && global.SAGEtoppin == true)
	{
		up = true;
		sprite = bg_SAGEtoppin;
		toppin = true;
		alarm[0] = 250;
	}
	else if (treasure == false && global.SAGEtreasure == true)
	{
		up = true;
		sprite = bg_SAGEtreasure;
		treasure = true;
		alarm[0] = 250;
	}
}
if (picy == 300)
{
	up = false;
}
if (up == true)
{
	picy -= 10;
}
