ID = 4;
with (instance_create_depth(0, 0, depth - 1, obj_itemlist))
{
	parent = other.id;
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	lst_add(items, 
	{
		name: "Room Settings",
		//PADDINGPADDINGPA
		func: function()
		{
			toggle_panel(7);
		}
	});
	lst_add(items, 
	{
		name: "Level Settings",
		//PADDINGPADDI
		func: function() {}
	});
	lst_add(items, 
	{
		name: "Save Level",
		//P
		func: function()
		{
			with (obj_editor)
			{
				if (editor_state != editorstates.level_save)
					save_level();
			}
		}
	});
	dirty = false;
	
	on_item_click = function(_item_id)
	{
		if (_item_id < ds_list_size(items))
		{
			items[| _item_id].func();
		}
	};
}
