function scr_player_addslopemomentum(_accel, _decel)
{
	with (instance_place(x, y + 1, obj_slope))
	{
		if (sign(image_xscale) == -sign(other.xscale))
		{
			if (abs(image_yscale) < abs(image_xscale))
			{
				other.movespeed += _accel;
			}
			else
			{
				other.movespeed += _decel;
			}
		}
	}
}

function scr_pizzaball_addslopemomentum(_accel, _decel)
{
	with (instance_place(x, y + 1, obj_slope))
	{
		if (sign(image_xscale) == -sign(other.image_xscale))
		{
			if (abs(image_yscale) < abs(image_xscale))
			{
				other.slopespeed += _accel;
			}
			else
			{
				other.slopespeed += _decel;
			}
		}
		else if (abs(image_yscale) < abs(image_xscale))
		{
			other.slopespeed -= _accel;
		}
		else
		{
			other.slopespeed -= _decel;
		}
	}
	if (slopespeed < 0)
	{
		slopespeed = 0;
	}
	if (slopespeed > 10)
	{
		slopespeed = 10;
	}
	if (movespeed < 1)
	{
		slopespeed = 0;
	}
}
