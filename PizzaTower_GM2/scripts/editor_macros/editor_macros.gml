enum editorstates
{
	init = 0,
	instance_edit = 1,
	unknown2 = 2, // toggles layer 1, but is unused.
	resize_room = 3,
	level_save = 4,
	level_load = 5,
}

enum instancestates
{
	normal = 0,
	move = 1,
	resize = 2,
}

enum docks
{
	top_left = 0,
	left = 1,
	bottom_left = 2,
	top_right = 3,
	right = 4,
	bottom_right = 5,
	top = 6,
	bottom = 7,
	last = 8,
}

enum dock_states
{
	free,
	docked
}

enum layertypes
{
	background = 0,
	tile = 1,
}

enum collisionflags
{
	secret = 1,
	on_slope = 2,
	on_floor = 4,
}
