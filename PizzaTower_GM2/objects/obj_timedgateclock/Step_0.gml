if (sprite_index == spr_button_goingpressed && ANIMATION_END)
{
	sprite_index = spr_button_pressed;
}
if (!global.timedgatetimer && sprite_index == spr_button_pressed)
{
	sprite_index = spr_button_goingidle;
}
if (sprite_index == spr_button_goingidle && ANIMATION_END)
{
	sprite_index = spr_button_idle;
}
