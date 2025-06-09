enum holidays
{
	normal = 0,
	halloween = 1,
}

function is_holiday(_holiday)
{
	if (global.holiday != _holiday)
	{
		return false;
	}
	var found = false;
	for (var i = 0; i < 3; i++)
	{
		if (global.game[i].judgement != "none" || global.gameN[i].judgement != "none")
		{
			found = true;
			return true;
		}
	}
	return false;
}
