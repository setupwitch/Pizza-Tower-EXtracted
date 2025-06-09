function cutscene_customer_check(_gnomeindex, _player, _gnomeID)
{
	with (obj_gnome_checklist)
	{
		gnome_check[_gnomeindex] = true;
	}
	global.pizzasdelivered++;
	if (instance_exists(obj_gnomecustomerblock))
	{
		instance_destroy(obj_gnomecustomerblock);
	}
	with (instance_create(_player.x, _player.y, obj_pizzaboxunopen))
	{
		content = _gnomeID.content;
		depth = _player.depth;
		visible = false;
	}
	ds_list_add(global.saveroom, _gnomeID.id);
	cutscene_end_action();
}

function cutscene_customer_end(_unknown)
{
	with (obj_customeractor)
	{
		happy = true;
	}
	cutscene_end_action();
}
