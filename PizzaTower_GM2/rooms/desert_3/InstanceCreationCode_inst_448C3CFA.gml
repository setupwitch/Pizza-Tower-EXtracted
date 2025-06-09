func = function(_id)
{
	if (active == false && _id.state == states.backbreaker)
	{
		active = true;
		obj_secretmanager.touchedtriggers += 1;
	}
};
