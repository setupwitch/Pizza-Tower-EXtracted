Thank you for using Pizza Tower Extracted!

Some things to note before using:

If you want compiled builds (builds compiled with "Create Executable") to work,
you need to enable debug mode on the Steamworks extension!

The unused folders *do* contain assets that are referenced in code, but in unused rooms.

Rooms can have instances that are disabled, when the GameMaker asset compiler goes through them,
it ignores the asset completely and still ticks the unique instance ID up.
This means that there are random disabled assets inside some rooms,
Most are placed with the context of older builds of the game or from surrounding instances.

CREDITS TO:
crystallizedsparkle - project lead and most of the work
obj_shaggy - project organization
TheWilmster - washing dishes and small help with code
Traxter64 - old instanceCC
