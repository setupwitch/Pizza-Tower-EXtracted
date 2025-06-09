function scr_add_wave(_wave_index, _baddie_num, _object_index, _rand, _spawn)
{
	var _wave = _wave_index;
	var _enemynumber = _baddie_num;
	var _obj = _object_index;
	var _random = _rand;
	var _spawnpoint = _spawn;
	baddie_arr[_wave][_enemynumber] = _obj;
	baddie_random[_wave][_enemynumber] = _random;
	if (!_random)
	{
		baddie_spawnpoint[_wave][_enemynumber] = _spawnpoint;
	}
}
