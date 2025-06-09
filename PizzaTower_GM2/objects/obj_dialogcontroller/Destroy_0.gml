with (obj_player)
{
	state = other.savedstate;
}
var func = dialog[currentdialog][2];
if (func != noone)
{
	if (npcID != noone && instance_exists(npcID))
	{
		with (npcID)
		{
			method(id, func)();
		}
	}
	else
	{
		method(id, func)();
	}
}
