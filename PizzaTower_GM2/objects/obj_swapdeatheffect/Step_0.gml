x += hsp;
y += vsp;
if (!ispeppino && vsp < 20)
{
	vsp += 0.5;
}
if (ANIMATION_END)
{
	switch (sprite_index)
	{
		case spr_player_outofpizza1:
			sprite_index = spr_player_outofpizza2;
			break;
		case spr_playerN_bossdeath1:
			sprite_index = spr_playerN_bossdeath1loop;
			break;
	}
}
