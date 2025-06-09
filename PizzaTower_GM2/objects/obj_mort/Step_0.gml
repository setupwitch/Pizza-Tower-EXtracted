if (ANIMATION_END && sprite_index == spr_mortspawn)
{
	sprite_index = spr_mortfall;
}
if (grounded && sprite_index == spr_mortfall)
{
	image_index = 0;
	sprite_index = spr_mortland;
}
if (ANIMATION_END && sprite_index == spr_mortland)
{
	sprite_index = spr_mortidle;
}
scr_collide();
