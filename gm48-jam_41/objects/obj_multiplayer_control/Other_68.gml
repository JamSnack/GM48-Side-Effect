/// @description Handle networking
var t = ds_map_find_value(async_load, "type");
switch(t)
{
	case network_type_connect:
	    var sock = ds_map_find_value(async_load, "socket");
	    ds_list_add(global.socketlist, sock);
		global.player_count = ds_list_size(global.socketlist)+1;
	break;
	
	case network_type_disconnect:
	    var sock = ds_map_find_value(async_load, "socket");
	    ds_list_delete(global.socketlist, ds_list_find_index(global.socketlist, sock));
		global.player_count = ds_list_size(global.socketlist)+1;
		
		var _str = "A player has disconnected.";
		hud_message(_str);
		send_chat(_str);
		
		if (instance_exists(obj_player_dummy))
			with (obj_player_dummy) instance_destroy(); //We can make new ones later
		
	break;
	
	case network_type_data:
		var data = async_load[? "buffer"];
		data = buffer_read(data,buffer_string);
		handle_data(data);
		//ds_list_add(packet_queue, data); //Put the data into the packet_queue.
	break;
}