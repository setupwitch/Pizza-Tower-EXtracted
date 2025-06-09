if (!instance_exists(bombID))
{
	exit;
}
array_push(bombID.baddie_arr, [other.id, 387]);
instance_destroy(bombID);
