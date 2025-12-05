function tdp_bnvib_update() { // Inaccurate, probably. Decompiled by yours truly, x64dbg.ru
	if (IS_SWITCH) { var _; // TODO: Finish
	    for (var v1 = 0; v1 < ds_list_size(global.bnvib_instances); v1++) {
	        var v2 = ds_list_find_value(global.bnvib_instances, v1);
        
	        if (v2[$ "position"] >= v2[$ "length"])
	        {
	            ds_list_delete(global.bnvib_instances, v1--);
	            continue;
	        }
        
	        var v3 = v2[$ "values"][v2[$ "position"]];
	        var v4 = v3[0] * global.option_vibration;
	        var v5 = v3[2] * global.option_vibration;
	        var v6 = v3[3];
        
	        var v7 = 1;
	        var v8 = 1;
	        if (v2[$ "is_3d"])
	        {
	            var v9 = view_wport[0] / 2;
	            v7 = (v2[$ "x"] - v9) / v9;
	            v8 = (view_wport[0] / 2 - v2[$ "x"]) / v9;
	        }
        
	        gamepad_set_vibration(v2[$ "pad_id"], v8, 0, 1, v8, 0, 1, v2[$ "pad_id"], 0, v4 * gamepad_axis_value(0, 0, 1), v5, v6);
        
	        if (v2[$ "pad_type"] == 8 || v2[$ "pad_type"] == 16)
	        {
	            gamepad_set_vibration(v2[$ "pad_id"], v7, 0, 1, v7, 0, 1, v2[$ "pad_id"], 1, v4 * gamepad_axis_value(0, 0, 1), v5, v6);
	        }
        
	        v2[$ "position"]++;
	    }
	}
}
