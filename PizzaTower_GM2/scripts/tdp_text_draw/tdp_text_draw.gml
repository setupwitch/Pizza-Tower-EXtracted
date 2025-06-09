function tdp_draw_text(_x, _y, _string)
{
	if (!global.tdp_text_enabled)
	{
		draw_text(_x, _y, _string);
	}
	else
	{
		var c = draw_get_color();
		var a = draw_get_alpha();
		tdp_text_action_text(_x, _y, _string, c, c, c, c, a);
	}
}

function tdp_draw_text_color(_x, _y, _string, _c1, _c2, _c3, _c4, _alpha)
{
	if (!global.tdp_text_enabled)
	{
		draw_text_color(_x, _y, _string, _c1, _c2, _c3, _c4, _alpha);
	}
	else
	{
		tdp_text_action_text(_x, _y, _string, _c1, _c2, _c3, _c4, _alpha);
	}
}

function tdp_draw_set_halign(_halign)
{
	draw_set_halign(_halign);
	if (global.tdp_text_enabled)
	{
		tdp_text_action_halign(_halign);
	}
}

function tdp_draw_set_valign(_valign)
{
	draw_set_valign(_valign);
	if (global.tdp_text_enabled)
	{
		tdp_text_action_valign(_valign);
	}
}

function tdp_draw_set_font(_font)
{
	draw_set_font(_font);
	if (global.tdp_text_enabled)
	{
		tdp_text_action_font(_font);
	}
}
