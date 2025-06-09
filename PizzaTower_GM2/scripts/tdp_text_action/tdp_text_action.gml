enum tdp_text_actiontypes
{
	halign = 0,
	valign = 1,
	text = 2,
	font = 3,
}

function tdp_text_action_halign(_halign)
{
	var b = 
	{
		type: tdp_text_actiontypes.halign,
		value: _halign
	};
	ds_queue_enqueue(global.tdp_text_queue, b);
}

function tdp_text_action_valign(_valign)
{
	var b = 
	{
		type: tdp_text_actiontypes.valign,
		value: _valign
	};
	ds_queue_enqueue(global.tdp_text_queue, b);
}

function tdp_text_action_font(_font)
{
	var b = 
	{
		type: tdp_text_actiontypes.font,
		value: _font
	};
	ds_queue_enqueue(global.tdp_text_queue, b);
}

function tdp_text_action_text(_x, _y, _text, _c1 = c_white, _c2 = c_white, _c3 = c_white, _c4 = c_white, _alpha = 1)
{
	var b = 
	{
		type: tdp_text_actiontypes.text,
		x: _x,
		y: _y,
		text: _text,
		c1: _c1,
		c2: _c2,
		c3: _c3,
		c4: _c4,
		image_alpha: _alpha
	};
	ds_queue_enqueue(global.tdp_text_queue, b);
}
