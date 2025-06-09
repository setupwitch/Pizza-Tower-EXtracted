function scr_hub_bg_init(_mult = 1)
{
	bgsprite = spr_gate_entranceBG;
	bgsprite_number = sprite_get_number(bgsprite);
	bgsprite_width = sprite_get_width(bgsprite);
	bgsprite_height = sprite_get_height(bgsprite);
	bgspritepos = 0;
	bgspriteposstart = 0;
	bgalpha = 1;
	bg_useparallax = false;
	bgparallax = [0.65 * _mult, 0.75 * _mult, 0.85 * _mult];
	bgparallax2 = [0.1 * _mult, 0.15 * _mult, 0.2 * _mult];
	bgmask_surface = noone;
	bgclip_surface = noone;
}

function scr_hub_bg_reinit(_xoffset, _yoffset)
{
	bgsprite_number = sprite_get_number(bgsprite);
	bgsprite_width = sprite_get_width(bgsprite);
	bgsprite_height = sprite_get_height(bgsprite);
	for (var i = 0; i < bgsprite_number; i++)
	{
		bgspritepos[i] = 0;
		if (bg_useparallax)
		{
			var p = bgparallax2[i];
			bgspriteposstart[i] = [_xoffset - (_xoffset * p) - ((SCREEN_WIDTH / 4) * p), _yoffset - (_yoffset * p) - ((SCREEN_HEIGHT / 4) * p)];
			bgspritepos[i] = [bgspriteposstart[i][0], bgspriteposstart[i][1]];
		}
	}
}

function scr_hub_bg_step()
{
	for (var i = 0; i < array_length(bgspritepos); i++)
	{
		if (!bg_useparallax)
		{
			bgspritepos[i] -= bgparallax[i];
			if (bgspritepos[i] <= -(bgsprite_width + bgparallax[i]))
			{
				bgspritepos[i] = frac(bgspritepos[i]);
			}
		}
		else
		{
			var p = bgparallax2[i];
			bgspritepos[i][0] = bgspriteposstart[i][0] + ((camera_get_view_x(view_camera[0]) + (SCREEN_WIDTH / 2)) * p) + ((SCREEN_WIDTH / 5) * p);
			bgspritepos[i][1] = bgspriteposstart[i][1] + ((camera_get_view_y(view_camera[0]) + (SCREEN_HEIGHT / 2)) * p);
		}
	}
}

function scr_hub_bg_draw(_x, _y, _sprite, _subimg, _isgui = false)
{
	if (bgalpha < 1)
	{
		var w = sprite_get_width(_sprite);
		var h = sprite_get_height(_sprite);
		var x1 = sprite_get_xoffset(_sprite);
		var y1 = sprite_get_yoffset(_sprite);
		if (!surface_exists(bgmask_surface))
		{
			bgmask_surface = surface_create(w, h);
			surface_set_target(bgmask_surface);
			draw_clear(c_black);
			gpu_set_blendmode(bm_subtract);
			draw_sprite(_sprite, _subimg, x1, y1);
			if (!_isgui)
			{
				gpu_set_blendmode(bm_normal);
			}
			else
			{
				reset_blendmode();
			}
			surface_reset_target();
		}
		if (!surface_exists(bgclip_surface))
		{
			bgclip_surface = surface_create(w, h);
		}
		surface_set_target(bgclip_surface);
		draw_clear_alpha(c_black, 0);
		for (var i = 0; i < array_length(bgspritepos); i++)
		{
			if (!bg_useparallax)
			{
				var b = bgspritepos[i];
				draw_sprite_tiled(bgsprite, i, b, h);
			}
			else
			{
				var bx = bgspritepos[i][0];
				var by = bgspritepos[i][1];
				draw_sprite_tiled(bgsprite, i, bx - _x, (by + h) - _y);
			}
		}
		gpu_set_blendmode(bm_subtract);
		draw_surface(bgmask_surface, 0, 0);
		if (!_isgui)
		{
			gpu_set_blendmode(bm_normal);
		}
		else
		{
			reset_blendmode();
		}
		surface_reset_target();
		draw_surface(bgclip_surface, _x - x1, _y - y1);
	}
	if (bgalpha > 0)
	{
		draw_sprite_ext(_sprite, _subimg, _x, _y, image_xscale, image_yscale, image_angle, image_blend, bgalpha);
	}
}
