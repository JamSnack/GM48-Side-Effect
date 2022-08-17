/// @description Insert description here
// You can write your code in this editor

//Handle data
/*if (global.multiplayer == true)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "stress_test";
	_d[? "value"] = val;
	send_data(_d);
}
else val = 0;


val++;
/*
if (ds_exists(packet_queue, ds_type_list) && ds_list_size(packet_queue) != 0)
{
	var data = packet_queue[| 0];
	var _success = handle_data(data);
	
	if (_success == false)
	{
		show_debug_message("Data insuccessfully parsed.");	
		//Inform the server?
	}
	
	ds_list_delete(packet_queue, 0); //Get rid of the data either way. No point in trying to re-parse data that's broken!
}