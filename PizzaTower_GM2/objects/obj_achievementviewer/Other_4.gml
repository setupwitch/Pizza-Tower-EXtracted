var ach = achievement_get_struct(achievement);
if (ach != noone)
{
	if (ach.unlocked)
	{
		hidden = false;
		image_index = index;
	}
	else
	{
		image_index = index + secretplus;
	}
}
else
{
	trace("Not found secret: ", achievement);
	image_index = index + secretplus;
}
textfont = lang_get_font("creditsfont");
var _title = achievement;
if (title_override != noone)
{
	_title = title_override;
}
var _desc = _title;
if (desc_override != noone)
{
	_desc = desc_override;
}
if (hidden)
{
	texttitle = lang_get_value("achievement_hiddentitle");
}
else
{
	texttitle = lang_get_value(concat("achievement_", _title, "title"));
}
textdesc = lang_get_value(concat("achievement_", _desc));
if (is_string(textdesc))
{
	textdesc = string_replace_all(textdesc, "\\n", "\n");
}
