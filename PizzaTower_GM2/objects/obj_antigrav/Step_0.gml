if (use_collision)
{
	scr_collide();
}
if (sprite_index == spr_antigrav_activate && ANIMATION_END)
{
	sprite_index = spr_antigrav;
}
if (cooldown > 0)
{
	cooldown--;
}
