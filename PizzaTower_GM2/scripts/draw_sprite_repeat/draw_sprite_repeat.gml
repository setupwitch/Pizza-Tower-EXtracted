function draw_sprite_repeat(_spr, _subimg, _x, _y, _width, _height)
{
	var spr_w = sprite_get_width(_spr);
	var spr_h = sprite_get_height(_spr);
	var nx = floor(_width / spr_w);
	var ny = floor(_height / spr_h);
	var dx = 0;
	var dy = 0;
	if (nx == 0 || ny == 0)
	{
		draw_sprite_part(_spr, _subimg, 0, 0, _width, _height, _x, _y);
		if (ny == 0)
		{
			dy = 0;
			for (var xx = 0; xx < nx; xx++)
			{
				draw_sprite_part(_spr, _subimg, 0, 0, spr_w, _height, _x + dx, _y + dy);
				dx += spr_w;
				if (xx == (nx - 1))
				{
					draw_sprite_part(_spr, _subimg, 0, 0, _width - dx, _height, _x + dx, _y + dy);
				}
			}
		}
		if (nx == 0)
		{
			dx = 0;
			for (var yy = 0; yy < ny; yy++)
			{
				draw_sprite_part(_spr, _subimg, 0, 0, _width, _height, _x, _y + dy);
				dy += spr_h;
				if (yy == (ny - 1))
				{
					draw_sprite_part(_spr, _subimg, 0, 0, _width, _height - dy, _x, _y + dy);
				}
			}
		}
	}
	else
	{
		for (var yy = 0; yy < ny; yy++)
		{
			dx = 0;
			for (var xx = 0; xx < nx; xx++)
			{
				draw_sprite_ext(_spr, _subimg, _x + dx, _y + dy, 1, 1, 0, c_white, draw_get_alpha());
				if (yy == (ny - 1))
				{
					draw_sprite_part(_spr, _subimg, 0, 0, spr_w, _height - (dy + spr_h), _x + dx, _y + (dy + spr_h));
				}
				dx += spr_w;
				var dp = xx == (nx - 1);
				if (dp)
				{
					draw_sprite_part(_spr, _subimg, 0, 0, _width - dx, spr_h, _x + dx, _y + dy);
					if (yy == (ny - 1))
					{
						draw_sprite_part(_spr, _subimg, 0, 0, _width - dx, _height - (dy + spr_h), _x + dx, _y + (dy + spr_h));
					}
				}
			}
			dy += spr_h;
		}
	}
}
