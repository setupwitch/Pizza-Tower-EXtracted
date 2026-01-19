function tdp_bnvib_init() // Decompiled by yours truly, x64dbg.ru
{
	if (IS_SWITCH)
	{
		global.bnvib_map = ds_map_create();
	    global.bnvib_instances = ds_list_create();
	    global.bnvib_to_load =
		[
	        ["land", "rom:/bnvib/land.bnvib", 3 / 5],
	        ["collect", "rom:/bnvib/collect.bnvib", 0],
	        ["bigcollect", "rom:/bnvib/bigcollect.bnvib", 0],
	        ["enterbox", "rom:/bnvib/enterbox.bnvib", 0],
	        ["groundpound", "rom:/bnvib/groundpound.bnvib"],
	        ["groundpound_big", "rom:/bnvib/groundpound_big.bnvib"],
	        ["breakblock", "rom:/bnvib/breakblock.bnvib", 2 / 5],
	        ["punch", "rom:/bnvib/punch.bnvib", 3 / 5],
	        ["breakmetal", "rom:/bnvib/breakmetal.bnvib"],
	        ["secretenter", "rom:/bnvib/secretenter.bnvib", 1 / 5],
	        ["secretexit", "rom:/bnvib/secretexit.bnvib", 1 / 5],
	        ["dive", "rom:/bnvib/dive.bnvib"],
	        ["grab", "rom:/bnvib/grab.bnvib", 0],
	        ["parry", "rom:/bnvib/parry.bnvib"],
	        ["thunder", "rom:/bnvib/thunder.bnvib"],
	        ["johndead", "rom:/bnvib/JOHN_PILLAR_IMPACT.bnvib"],
	        ["firemouthstart", "rom:/bnvib/firemouthstart.bnvib"],
	        ["firemouthdash", "rom:/bnvib/firemouthdash.bnvib"],
	        ["firemouthjump", "rom:/bnvib/firemouthjump.bnvib"],
	        ["N_wallbounce", "rom:/bnvib/N_wallbounce.bnvib", 2 / 5],
	        ["N_wallbounceland", "rom:/bnvib/N_wallbounceland.bnvib", 2 / 5]
	    ];
	}
}
