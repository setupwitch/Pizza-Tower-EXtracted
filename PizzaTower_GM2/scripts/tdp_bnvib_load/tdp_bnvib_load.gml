function tdp_bnvib_load(_bnvib_name, _bnvib_file, _amplitude = 1) // Decompiled by yours truly, x64dbg.ru
{ 
	if (IS_SWITCH)
	{
		// get the BNVIB ID
	    var _bnvib = switch_bnvib_load(_bnvib_file);
	    
	    if (_bnvib == -1) // load failed
	        exit;
		
	    var _length = switch_bnvib_get_length(_bnvib); 
	    var _values = [];

	    for (var i = 0; i != _length; i++)
		{
	        var _bnvib_value = switch_bnvib_get_value(_bnvib, i);
	        _bnvib_value[0] *= _amplitude;
	        _bnvib_value[2] *= _amplitude;
	        array_push(_values, _bnvib_value);
	    }
		
	    var _bnvib_data =
		{
	        values: _values,
	        length: _length,
	    };
		// after getting the important data, unload
	    switch_bnvib_unload(_bnvib);
		
		global.bnvib_map[? _bnvib_name] = _bnvib_data;
		
	    return _bnvib_data;
	}
}
