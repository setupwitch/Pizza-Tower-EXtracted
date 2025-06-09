function EditorObject(_id, _name, _spr, _obj, _tilesnap = 32) constructor
{
	sprite_index = _spr;
	object_index = _obj;
	mask_index = _spr;
	name = _name;
	ID = _id;
	xoffset = 0;
	yoffset = 0;
	snap_tile_val = _tilesnap;
}
