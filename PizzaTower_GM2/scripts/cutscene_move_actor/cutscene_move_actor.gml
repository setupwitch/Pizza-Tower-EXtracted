function cutscene_move_actor(_inst, _x, _y, _amount)
{
	var _obj = _inst;
	var xx = _x;
	var yy = _y;
	var interp = _amount;
	var finish = false;
	with (_obj)
	{
		x = lerp(x, xx, interp);
		y = lerp(y, yy, interp);
		if (x > (xx - 6) && x < (xx + 6) && y > (yy - 6) && y < (yy + 6))
		{
			finish = true;
		}
	}
	if (finish)
	{
		cutscene_end_action();
	}
}
