function tdp_bnvib_update() // Decompiled by yours truly, x64dbg.ru
{
	if (IS_SWITCH)
	{
	    for (var i = 0; i < ds_list_size(global.bnvib_instances); i++)
		{
			// fetch the instance
	        var _bnvib_inst = global.bnvib_instances[| i];
	        
	        if (_bnvib_inst[$ "position"] == _bnvib_inst[$ "length"])
	        {
	            ds_list_delete(global.bnvib_instances, i--);
	            continue;
	        }
	        
	        var _position = _bnvib_inst[$ "values"][_bnvib_inst[$ "position"]];
	        var _low_amp = _position[0] * global.option_vibration;
	        var _low_freq = _position[1];
	        var _high_amp = _position[2] * global.option_vibration;
	        var _high_freq = _position[3];
	        
	        var _pan_right = 1;
	        var _pan_left = 1;
	        if (_bnvib_inst[$ "is_3d"])
	        {
	            var _center = SCREEN_WIDTH / 2;
				
	            _pan_right = _bnvib_inst[$ "x"] / _center;
	            _pan_left = (SCREEN_WIDTH - _bnvib_inst[$ "x"]) / _center;
	        }
	        
	        switch_controller_vibrate_hd(_bnvib_inst[$ "pad_id"], switch_controller_motor_left, _low_amp * clamp(_pan_left, 0, 1), _low_freq, _high_amp * clamp(_pan_left, 0, 1), _high_freq);
	        
	        if (_bnvib_inst[$ "pad_type"] != switch_controller_joycon_left && _bnvib_inst[$ "pad_type"] != switch_controller_joycon_right)
			{
	            switch_controller_vibrate_hd(_bnvib_inst[$ "pad_id"], switch_controller_motor_right, _low_amp * clamp(_pan_right, 0, 1), _low_freq, _high_amp * clamp(_pan_right, 0, 1), _high_freq);
	        }
			
	        _bnvib_inst[$ "position"]++;
	    }
	}
}
