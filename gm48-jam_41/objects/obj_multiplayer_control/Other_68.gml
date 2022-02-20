/// @description Handle networking

var t = ds_map_find_value(async_load, "type");
switch(t)
{
	case network_type_connect:
	    var sock = ds_map_find_value(async_load, "socket");
	    ds_list_add(global.socketlist, sock);
	break;
	
	case network_type_disconnect:
	    var sock = ds_map_find_value(async_load, "socket");
	    ds_map_delete(global.socketlist, sock);
	break;
	
	case network_type_data:
		var data = async_load[? "buffer"];
	    handle_data(data);
	break;
}