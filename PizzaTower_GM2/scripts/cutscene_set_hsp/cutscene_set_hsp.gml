function cutscene_set_hsp(_inst, _spd)
{
	var _obj = _inst;
	var _hsp = _spd;
	with (_obj)
	{
		hsp = _hsp;
	}
	cutscene_end_action();
}

function cutscene_set_vsp(_inst, _spd)
{
	with (_inst)
	{
		vsp = _spd;
	}
	cutscene_end_action();
}
