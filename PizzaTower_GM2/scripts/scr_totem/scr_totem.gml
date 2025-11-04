function totem_empty(_totem)
{
	with (_totem)
	{
		for (var i = 0; i < array_length(cheeseID); i++)
		{
			if (cheeseID[i] == noone)
			{
				return true;
			}
		}
		return false;
	}
}

function totem_add(_totem, _indian)
{
	with (_totem)
	{
		for (var i = 0; i < array_length(cheeseID); i++)
		{
			if (cheeseID[i] == noone)
			{
				cheeseID[i] = _indian;
				return true;
			}
		}
		return false;
	}
}

function totem_clear(_totem)
{
	with (_totem)
	{
		for (var i = 0; i < array_length(cheeseID); i++)
		{
			if (cheeseID[i] != noone && (!instance_exists(cheeseID[i]) || cheeseID[i].state != states.dance))
			{
				if (instance_exists(cheeseID[i]))
				{
					cheeseID[i].totemID = noone;
				}
				cheeseID[i] = noone;
			}
		}
	}
}

function totem_count(_totem)
{
	var c = 0;
	with (_totem) 
	{
		for (var i = 0; i < array_length(cheeseID); i++)
		{
			if (cheeseID[i] != noone)
			{
				c++;
			}
		}
		return c;
	}
}
