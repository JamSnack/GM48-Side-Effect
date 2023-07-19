/// @description Handle networking
var t = ds_map_find_value(async_load, "type");
switch(t)
{
	case network_type_connect:
	{
	    var sock = ds_map_find_value(async_load, "socket");
	    ds_list_add(global.socketlist, sock);
		global.player_count = ds_list_size(global.socketlist)+1;
	}
	break;
	
	case network_type_disconnect:
	{
	    var sock = ds_map_find_value(async_load, "socket");
	    ds_list_delete(global.socketlist, sock);
		global.player_count = ds_list_size(global.socketlist)+1;
	}
	break;
	
	case network_type_data:
	{
		var b_data = async_load[? "buffer"];
		var data = buffer_read(b_data, buffer_text);
		
		//unpickle the data
		var _l = string_length(data)
		var temp_data = "";
		
		//March through each character, 
		//appending to temp_data until we reach the end of the packet.
		
		for (var i = 1; i <= _l; i++)
		{
			var _c = string_char_at(data, i);
			
			temp_data += _c;
			
			//We have found the end of the packet, handle the data.
			if (_c == "}")
			{
				handle_data(temp_data);
				temp_data = "";
			}
		}
		
		//buffer cleanup
		buffer_delete(b_data);
	}
	break;
}