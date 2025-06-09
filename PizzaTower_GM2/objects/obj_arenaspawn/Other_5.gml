ds_list_destroy(baddielist);
if (state == states.victory || state == states.transitioncutscene)
{
	event_perform(ev_destroy, 0);
}
