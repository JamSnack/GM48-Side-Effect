/// @description Insert description here
// Sync object destruction
if (global.is_host == true)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "object_destroy";
	_d[? "object_index"] = object_index;
	_d[? "object_id"] = object_id;
	send_data(_d);
}