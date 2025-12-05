function tdp_bnvib_play_3d(a0, a1, a2) { // Decompiled by yours truly, x64dbg.ru
	if (IS_SWITCH) {
	    var v1 = camera_get_view_x(view_camera);
	    var v2 = camera_get_view_y(view_camera);
	    var v3 = camera_get_view_width(view_camera);
	    var v4 = camera_get_view_height(view_camera);
	    var v5 = 20;
	    if (a0 <= v1 - v5 || a0 >= v1 + v3 + v5 || a1 <= v2 - v5) return noone; // jmp label1
	    if (a1 < v2 + v4 + v5) {
	        var v6 = tdp_bnvib_play(a2);
        
	        v6.x = a0 - v1; // there was a variable declaration here seemingly but maybe im schizo
	        v6.y = a1 - v2; // same thing here
	        v6.is_3d = true;

	        return v6;
	    }

	    return noone; // label1
	}
}

function tdp_bnvib_play(a0) {
	if (IS_SWITCH) { // trace.line = 25;
	    var v1 = ds_map_find_value(global.bnvib_map, a0);
    
	    if (is_undefined(v1))
	        exit; // jump out
	    var v2 = 0; // unkInputDevice
	    if (instance_exists(obj_inputAssigner))
	        v2 = obj_inputAssigner.player_input_device[obj_inputAssigner.player_index]

	    if (v2 < 0)
	        v2 = 0;
    
	    var v3 = (1 << 0);
	    var v4 = gamepad_get_description(v2);
	    if (v4 == "Handheld") // ??? no this is not a switch statement and yes it BARELY matches the trace line info.
	        v3 = (1 << 0); else if (v4 == "Pro Controller")
	        v3 = (1 << 1); else if (v4 == "Joy-Con")
	        v3 = (1 << 2); else if (v4 == "Joy-Con (L)")
	        v3 = (1 << 3); else if (v4 == "Joy-Con (R)")
	        v3 = (1 << 4);
    
	    var v5 = {
	        position: 0,
	        values: v1.values,
	        length: v1.length,
	        x: 0,
	        y: 0,
	        is_3d: false,
	        pad_id: v2,
	        pad_type: v3
	    }
	    ds_list_add(global.bnvib_instances, v5);
    
	    return v5;
	}
}
