if (cooldown > 0)
{
	cooldown--;
}
if (sprite_index == spr_cowkick)
{
	if (ANIMATION_END)
	{
		sprite_index = spr_cowidle;
	}
}
else if (blink)
{
	image_index = 1;
	blink = false;
}
else
{
	image_index = 0;
}
