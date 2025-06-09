switch (state)
{
	case states.normal:
		break;
	case states.transitioncutscene:
		if (ANIMATION_END)
		{
			instance_activate_object(bossdoorID);
			with (bossdoorID)
			{
				vsp = -5;
				state = states.jump;
				event_perform(ev_other, ev_room_start);
			}
			state = states.jump;
		}
		break;
	case states.jump:
		sprite_index = spr_mrstick_helicopterhat;
		y -= 10;
		if (y < -100)
		{
			instance_destroy();
		}
		break;
}
