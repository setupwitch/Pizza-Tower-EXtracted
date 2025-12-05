function tdp_bnvib_load(a0, a1, a2 = 1) { // Decompiled by yours truly, x64dbg.ru
	if (IS_SWITCH) { // SYYStackTrace.line = 3
	    var v1 = switch_bnvib_load(a1);
	    // SYYStackTrace.line = 5
	    if (v1 == -1) // load failed
	        exit; // or maybe return would fit more? basically, jump out at line 6
	    // SYYStackTrace.line = 8
	    var v2 = switch_bnvib_get_length(v1); // SYYStackTrace.line = 9
	    var v3 = array_create(0); // guess. argument here is unknown, and not set anywhere at runtime seemingly, so i assume 0.
	    // SYYStackTrace.line = 11
	    for (var v4 = 0; v4 != v2; v4++) { // SYYStackTrace.line = 12
	        var v5 = switch_bnvib_get_value(v1, v4); // SYYStackTrace.line = 13
	        v5[0] *= a2; // push pop ctx stack ; SYYStackTrace.line = 14
	        v5[2] *= a2; // push pop ctx stack ; SYYStackTrace.line = 15
	        array_push(v3, v5);
	    } // increment v4 (end of for loop)
	    // SYYStackTrace.line = 18
	    var v6 = { // this looks to be the right correct absolute struct but im still not sure because structs in yyc are wonky.
	        values: v3,
	        length: v2,
	    };
	    // SYYStackTrace.line = 23
	    switch_bnvib_unload(v1); // SYYStackTrace.line = 24
	    ds_map_set(global.bnvib_map, a0, v6);
	    // SYYStackTrace.line = 26
	    return v6; // ???
	}
}
