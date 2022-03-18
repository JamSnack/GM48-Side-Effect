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
	    ds_list_delete(global.socketlist, sock);
		global.player_count = ds_list_size(global.socketlist)+1;
		
	break;
	
	case network_type_data:
		var b_data = async_load[? "buffer"];
		var data = buffer_read(b_data,buffer_string);
		handle_data(data);
		
		//buffer cleanup
		buffer_delete(b_data);
		//ds_list_add(packet_queue, data); //Put the data into the packet_queue.
	break;
}