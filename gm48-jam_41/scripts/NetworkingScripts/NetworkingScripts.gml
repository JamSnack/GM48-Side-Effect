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
		
		case "player_sync":
		{
			if (instance_exists(obj_player_dummy))
			{
				var _p_id = parsed_data[? "id"];
				with (obj_player_dummy)
				{
					if (p_id != _p_id)
						continue;
					else
					{
						x = parsed_data[? "x"];	
						y = parsed_data[? "y"];
						hspd = parsed_data[? "hspd"];
						vspd = parsed_data[? "vspd"];
					}
				}
			}
			else
			{
				var _p = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", obj_player_dummy);
				_p.p_id = parsed_data[? "id"];
				_p.hspd = parsed_data[? "hspd"];
				_p.vspd = parsed_data[? "vspd"];
			}
		}
		break;
		
		case "player_stats_sync":
		{
			if (instance_exists(obj_player_dummy))
			{
				var _p_id = parsed_data[? "id"];
				with (obj_player_dummy)
				{
					if (p_id != _p_id)
						continue;
					else
					{
						hp = parsed_data[? "hp"];	
						maxHp = parsed_data[? "maxHp"];
					}
				}
			}
		}
		break;
		
		case "tile_destroy":
		{
			var _x = parsed_data[? "x"];
			var _y = parsed_data[? "y"];
			instance_activate_region(_x,_y,1,1,true);
			
			var _t = collision_point(_x,_y,obj_tile,false,false);
			
			if (_t != noone)
			{
				with (_t)
				{
					if (item_id == parsed_data[? "type"])
					{
						instance_destroy();	
					}
				}
			}
		}
		break;
		
		case "item_sync":
		{
			var o_id = parsed_data[? "object_id"];
			
			with (obj_item)
			{
				if (object_id != o_id)
					continue;
				
				x = parsed_data[? "x"];
				y = parsed_data[? "y"];
				break;
			}
		}
		break;
		
		case "inventory_add_item":
		{
			if (parsed_data[? "p_id"] == global.player_id)
			{
				//We received an item!
				global.inventory[parsed_data[? "item"]] += 1;
			
				update_inventory();
				_sn = audio_play_sound(snd_true_blip,1,false);
				audio_sound_pitch(_sn,choose(0.99,0.995,1,1.1));
			}
		}
		break;
		
		case "wave_sync":
		{
			if (instance_exists(obj_control))
			{
				with (obj_control)
				{
					time_mil = parsed_data[? "time_mil"];
					time_m = parsed_data[? "time_m"];
					time_h = parsed_data[? "time_h"];
					difficulty = parsed_data[? "difficulty"];
				}
			}
		}
		break;
		
		case "chat_message":
		{
			hud_message(parsed_data[? "message"]);
		}
		break;
		
		case "enemy_sync":
		{
			var o_index = parsed_data[? "object_index"];
			
			if (instance_exists(o_index))
			{
				var _o_id = parsed_data[? "id"];
				with (o_index)
				{
					if (object_id != _o_id)
						continue;
					else
					{
						x = parsed_data[? "x"];	
						y = parsed_data[? "y"];
						hAccel = parsed_data[? "hAccel"];
						vAccel = parsed_data[? "vAccel"];
					}
				}
			}
			else
			{
				var _p = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", o_index);
				_p.object_id = parsed_data[? "id"];
				_p.hAccel = parsed_data[? "hAccel"];
				_p.vAccel = parsed_data[? "vAccel"];
			}
		}
		break;
		
		case "object_destroy":
		{
			var o_index = parsed_data[? "object_index"];
			
			if (instance_exists(o_index))
			{
				var _id = parsed_data[? "object_id"];
				with (o_index)
				{
					if (object_id != _id)
						continue;
					else 
					{
						instance_destroy();
						break;
					}
				}
			}
		}
		break;
	}
}