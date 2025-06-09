function scr_add_grannypizzaboss(_ini_section, _ini_key, _icon)
{
	var q = scr_add_grannypizzalevel(_ini_key, _icon, false, false, false, true);
	ini_open_from_string(obj_savesystem.ini_str);
	if (ini_read_real(_ini_section, "unlocked", false) == false)
	{
		array_pop(levelarray);
	}
	ini_close();
}

function scr_add_grannypizzalevel(_ini_key, _icon, _secrets = true, _toppins = true, _treasure = true, _rank = true)
{
	var q = 
	{
		icon: _icon,
		secrets: _secrets,
		secretcount: 0,
		toppins: _toppins,
		toppinarr: [false, false, false, false, false],
		treasure: _treasure,
		gottreasure: false,
		rank: _rank,
		gotrank: noone
	};
	ini_open_from_string(obj_savesystem.ini_str);
	if (q.secrets)
	{
		q.secretcount = ini_read_real("Secret", _ini_key, 0);
	}
	if (q.toppins)
	{
		for (var i = 0; i < array_length(q.toppinarr); i++)
		{
			q.toppinarr[i] = ini_read_real("Toppin", concat(_ini_key, i + 1), false);
		}
	}
	if (q.treasure)
	{
		q.gottreasure = ini_read_real("Treasure", _ini_key, false);
	}
	if (q.rank)
	{
		q.gotrank = ini_read_string("Ranks", _ini_key, "none");
	}
	ini_close();
	array_push(levelarray, q);
	return q;
}
