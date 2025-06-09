event_inherited();
requires_level = true;
ID = noone;
items = ds_list_create();
item_height = 32;
item_sprite = spr_button_nineslice;
scroll = 0;
selected_item = noone;
dirty = true;
clicked = false;
surf = noone;

on_item_click = function(_item_index)
{
	if (_item_index < ds_list_size(items))
	{
		if (selected_item == _item_index)
		{
			on_item_double_click(_item_index);
		}
		selected_item = _item_index;
	}
	else
	{
		selected_item = noone;
	}
};

on_item_double_click = function(_item_index)
{
	trace("double clicked item ", _item_index);
};

on_item_draw = function(_x, _y, _item)
{
	if (draw_get_font() != 0)
	{
		draw_set_font(fnt_caption);
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text_color(_x + 12, _y + (item_height / 2), _item.name, c_white, c_white, c_white, c_white, 1);
};

on_dirty = function()
{
	trace("list dirty");
	dirty = false;
};

on_left_click = function()
{
	var yy = get_list_pos(obj_editorcursor.y);
	if (yy < 0)
	{
		exit;
	}
	clicked = true;
	on_item_click(yy);
};
