// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createServer(port, max_clients)
{
	global.socket = network_create_server(network_socket_tcp, port, max_clients);
	
	if (global.socket < 0)
	{
		//Failed...	
		global.is_host = false;
		global.multiplayer = false;
		server_status = "Server failed.";
	}
	else
	{
		//Succ
		global.is_host = true;
		global.multiplayer = true;
		server_status = "Server created.";
	}
}

function joinServer(ip, port)
{
	server_status = "Connecting to server...";
	
	global.socket = network_create_socket(network_socket_tcp);
	
	var _s = network_connect(global.socket, ip, port);
	
	if (_s < 0)
	{
		//Failed...
		global.is_host = false;
		global.multiplayer = false;
		server_status = "Failed to join "+ ip +". Try again.";
	}
	else
	{
		//Succ..!
		global.is_host = false;
		global.multiplayer = true;
		server_status = "Server joined!";
	}	
}

function send_data(data_map)
{
	var json_map = json_encode(data_map);
	//show_debug_message("sending: "+json_map);
	var buff = buffer_create(64, buffer_grow, 1);
	
	buffer_seek(buff, buffer_seek_start, 0);
	var _b = buffer_write(buff, buffer_string, json_map);
	
	if (_b == -1) then show_debug_message("buffer_write failed.");
	show_debug_message("sending: "+buffer_read(buff, buffer_string));
	
	if (global.multiplayer == true)
	{
		if (global.is_host == false)
		{
			network_send_packet(global.socket, buff, buffer_tell(buff));
		}
		else
		{
			for (var i = 0; i < ds_list_size(global.socketlist); ++i;)
		    {
				network_send_packet(ds_list_find_value(global.socketlist, i), buff, buffer_tell(buff));
		    }
		}
	}
	
	//cleanup
	buffer_delete(buff);
	
	if (ds_exists(data_map, ds_type_map))
	{
		ds_map_destroy(data_map);	
	}
}

function handle_data(data)
{
	var parsed_data = json_decode( buffer_read(data,buffer_string) );
	show_debug_message("Handling data: "+string(data));
	
	switch parsed_data[? "cmd"]
	{
		case "generate_world":
		{
			show_debug_message("Generate gate 1!");
			if (instance_exists(obj_menu_control) && obj_menu_control.begin_sequence = false)
			{
				show_debug_message("Generate gate 2!");
				random_set_seed(parsed_data[? "seed"]);
				obj_menu_control.begin_sequence = true;
			}
		}
		break;
	}
}