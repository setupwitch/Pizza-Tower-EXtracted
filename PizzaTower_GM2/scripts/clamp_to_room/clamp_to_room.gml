/// @desc - Clamps object position to the room.
/// @arg {Struct.EditorRoom} _room - The EditorRoom to clamp to.
function clamp_to_room(_room)
{
	while (bbox_top < _room.y)
	{
		y++;
	}
	while (bbox_bottom > (_room.y + _room.height))
	{
		y--;
	}
	while (bbox_left < _room.x)
	{
		x++;
	}
	while (bbox_right > (_room.x + _room.width))
	{
		x--;
	}
}
