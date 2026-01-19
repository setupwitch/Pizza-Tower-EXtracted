function tdp_bnvib_update() { // Decompiled by yours truly, x64dbg.ru
	if (IS_SWITCH) {
	    for (var v1 = 0; v1 < ds_list_size(global.bnvib_instances); v1++) {
	        var v2 = ds_list_find_value(global.bnvib_instances, v1);
	        
	        if (v2[$ "position"] == v2[$ "length"])
	        {
	            ds_list_delete(global.bnvib_instances, v1--);
	            continue;
	        }
	        
	        var v3 = v2[$ "values"][v2[$ "position"]];
	        var v4 = v3[0] * global.option_vibration;
	        var v5 = v3[1];
	        var v6 = v3[2] * global.option_vibration;
	        var v7 = v3[3];
	        
	        var v8 = 1;
	        var v9 = 1;
	        if (v2[$ "is_3d"])
	        {
	            var v10 = obj_screensizer.actual_width / 2;
	            // unknown, could be empty
	            // unknown, could be empty
	            v8 = v2[$ "x"] / v10;
	            v9 = (obj_screensizer.actual_width - v2[$ "x"]) / v10;
	        }
	        
	        switch_controller_vibrate_hd(v2[$ "pad_id"], switch_controller_motor_left, v4 * clamp(v9, 0, 1), v5, v6 * clamp(v9, 0, 1), v7);
	        
	        if (v2[$ "pad_type"] != switch_controller_joycon_left && v2[$ "pad_type"] != switch_controller_joycon_right) {
	            switch_controller_vibrate_hd(v2[$ "pad_id"], switch_controller_motor_right, v4 * clamp(v8, 0, 1), v5, v6 * clamp(v8, 0, 1), v7);
	        }
	        v2[$ "position"]++;
	    }
	}
}
