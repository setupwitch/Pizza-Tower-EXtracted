function tdp_bnvib_init() { // Decompiled by yours truly, x64dbg.ru
	if (IS_SWITCH) { // SYYStackTrace.line = 3
		global.bnvib_map = ds_map_create(); // SYYStackTrace.line = 4
	    global.bnvib_instances = ds_list_create(); // SYYStackTrace.line = 5
	    global.bnvib_to_load = [ // stylistic choice, may differ from actual source.
	        ["land", "rom:/bnvib/land.bnvib", 0x9999999A],
	        ["collect", "rom:/bnvib/collect.bnvib", 0x0],
	        ["bigcollect", "rom:/bnvib/bigcollect.bnvib", 0x0],
	        ["enterbox", "rom:/bnvib/enterbox.bnvib", 0x0],
	        ["groundpound", "rom:/bnvib/groundpound.bnvib"],
	        ["groundpound_big", "rom:/bnvib/groundpound_big.bnvib"],
	        ["breakblock", "rom:/bnvib/breakblock.bnvib", 0x66666666],
	        ["punch", "rom:/bnvib/punch.bnvib", 0x9999999A],
	        ["breakmetal", "rom:/bnvib/breakmetal.bnvib"],
	        ["secretenter", "rom:/bnvib/secretenter.bnvib", 0x33333333],
	        ["secretexit", "rom:/bnvib/secretexit.bnvib", 0x33333333],
	        ["dive", "rom:/bnvib/dive.bnvib"],
	        ["grab", "rom:/bnvib/grab.bnvib", 0x0],
	        ["parry", "rom:/bnvib/parry.bnvib"],
	        ["thunder", "rom:/bnvib/thunder.bnvib"],
	        ["johndead", "rom:/bnvib/JOHN_PILLAR_IMPACT.bnvib"],
	        ["firemouthstart", "rom:/bnvib/firemouthstart.bnvib"],
	        ["firemouthdash", "rom:/bnvib/firemouthdash.bnvib"],
	        ["firemouthjump", "rom:/bnvib/firemouthjump.bnvib"],
	        ["N_wallbounce", "rom:/bnvib/N_wallbounce.bnvib", 0x66666666],
	        ["N_wallbounceland", "rom:/bnvib/N_wallbounceland.bnvib", 0x66666666]
	    ] // exit routine (GC; destructors)
	}
}
