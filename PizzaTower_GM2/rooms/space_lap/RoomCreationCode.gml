pal_swap_init_system(shd_pal_swapper);
global.roommessage = "PIZZA TOWER IN SPACE";
if (!obj_secretmanager.init)
{
	obj_secretmanager.init = true;
	//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPAD
	secret_add(noone,
	function()
	{
		secret_open_portal(0);
	});
	//PADDINGPADDINGPA
	secret_add(noone,
	function()
	{
		if (secret_check_trigger(1))
		{
			secret_open_portal(1);
		}
	});
	//PADDI
	secret_add(noone,
	function()
	{
		if (secret_check_trigger(2))
		{
			secret_open_portal(2);
		}
	});
}