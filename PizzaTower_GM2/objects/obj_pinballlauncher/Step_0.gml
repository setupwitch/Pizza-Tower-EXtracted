if (ANIMATION_END && sprite_index == spr_goblinbot_kick)
{
	sprite_index = spr_goblinbot;
}
if (use_collision)
{
	scr_collide();
}
if (rail)
{
	scr_rail_phy();
}
