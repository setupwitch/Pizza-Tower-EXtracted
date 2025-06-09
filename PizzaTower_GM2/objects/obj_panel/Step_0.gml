if (!active)
{
	exit;
}
var accel = 0.4;
switch (state)
{
	case dock_states.docked:
		switch (dock)
		{
			case docks.right:
				x = lerp(x, CAM_WIDTH, accel);
				break;
			case docks.left:
				x = lerp(x, -sprite_width, accel);
				break;
			case docks.top:
				y = lerp(y, -sprite_height, accel);
				break;
			case docks.bottom:
				y = lerp(y, CAM_HEIGHT, accel);
				break;
		}
		break;
	case dock_states.free:
		switch (dock)
		{
			case docks.right:
			case docks.left:
				x = lerp(x, xstart, accel);
				break;
			case docks.top:
			case docks.bottom:
				y = lerp(y, ystart, accel);
				break;
		}
		break;
}
