event_inherited();
if (state == states.ghostpossess && substate == states.normal)
{
	var _angle = point_direction(0, 0, moveX, moveY);
	var t = spr_gate_industrial;
	var lx = lengthdir_x(t, _angle);
	var ly = lengthdir_y(t, _angle);
	draw_sprite(spr_ball_move, 0, x + lx, y + ly);
}
