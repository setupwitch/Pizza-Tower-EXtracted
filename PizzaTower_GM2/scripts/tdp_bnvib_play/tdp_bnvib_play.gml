function tdp_bnvib_play_3d(_x, _y, _bnvib_name) // Decompiled by yours truly, x64dbg.ru
{ 
	if (IS_SWITCH)
	{
	    var _view_x = camera_get_view_x(view_camera);
	    var _view_y = camera_get_view_y(view_camera);
	    var _view_w = camera_get_view_width(view_camera);
	    var _view_h = camera_get_view_height(view_camera);
	    var _view_padding = 20;
		
	    if (_x <= _view_x - _view_padding || _x >= _view_x + _view_w + _view_padding || _y <= _view_y - _view_padding)
			return noone; // jmp label1
		
	    if (_y < _view_y + _view_h + _view_padding)
		{
	        var _bnvib_inst = tdp_bnvib_play(_bnvib_name);
        
	        _bnvib_inst.x = _x - _view_x; // there was a variable declaration here seemingly but maybe im schizo
	        _bnvib_inst.y = _y - _view_y; // same thing here
	        _bnvib_inst.is_3d = true;

	        return _bnvib_inst;
	    }

	    return noone; // label1
	}
}

function tdp_bnvib_play(_bnvib_name)
{
	if (IS_SWITCH)
	{
	    var _bnvib_data = global.bnvib_map[? _bnvib_name];
    
	    if (is_undefined(_bnvib_data))
	        exit;
			
	    var _pad_id = 0;
	    if (instance_exists(obj_inputAssigner))
	        _pad_id = obj_inputAssigner.player_input_device[obj_inputAssigner.player_index]

	    if (_pad_id < 0)
	        _pad_id = 0;
		
	    var _pad_type = switch_controller_handheld;
	    var _desc = gamepad_get_description(_pad_id);
		
	    if (_desc == "Handheld")
	        _pad_type = switch_controller_handheld;
		else if (_desc == "Pro Controller")
	        _pad_type = switch_controller_pro_controller;
		else if (_desc == "Joy-Con")
	        _pad_type = switch_controller_joycon_dual;
		else if (_desc == "Joy-Con (L)")
	        _pad_type = switch_controller_joycon_left;
		else if (_desc == "Joy-Con (R)")
	        _pad_type = switch_controller_joycon_right;
    
	    var _bnvib_inst =
		{
	        position: 0,
	        values: _bnvib_data.values,
	        length: _bnvib_data.length,
	        x: 0,
	        y: 0,
	        is_3d: false,
	        pad_id: _pad_id,
	        pad_type: _pad_type
	    }
		
	    ds_list_add(global.bnvib_instances, _bnvib_inst);
    
	    return _bnvib_inst;
	}
}
