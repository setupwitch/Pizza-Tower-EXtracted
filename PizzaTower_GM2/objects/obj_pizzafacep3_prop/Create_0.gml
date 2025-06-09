hsp = 0;
vsp = 0;
hsp_carry = 0;
vsp_carry = 0;
grav = 0.5;
platformid = noone;
grounded = false;
usepalette = false;
start = false;
stunspr = noone;
angryspr = noone;
use_collision = true;
spr_palette = spr_peppalette;
paletteselect = 1;
with (instance_create(x, y + 10, obj_jumpdust))
{
	image_xscale = -1;
}
