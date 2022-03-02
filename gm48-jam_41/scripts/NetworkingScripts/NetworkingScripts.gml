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
	
	var _s = network_connect_async(global.socket, ip, port);
	
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
	
	if (global.multiplayer == true)
	{
		if (global.is_host == false)
		{
			network_send_packet(global.socket, buff, buffer_tell(buff));
		}
		else
		{
			for (var i = 0; i < ds_list_size(global.socketlist); i++;)
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
	var parsed_data = json_decode(data);
	var successful_parse = false;
	
	show_debug_message("Handling data: "+string(data));
	
	
	if (ds_exists(parsed_data,ds_type_map))
	{
		successful_parse = true;
		
		switch parsed_data[? "cmd"]
		{
			case "generate_world":
			{
				show_debug_message("Generate gate 1!");
				if (instance_exists(obj_menu_control) && obj_menu_control.begin_sequence = false)
				{
					show_debug_message("Generate gate 2!");
					var _rng_seed = parsed_data[? "seed"];
					global.game_seed = _rng_seed;
					random_set_seed(_rng_seed);
					obj_menu_control.begin_sequence = true;
				}
			}
			break;
		
			case "player_sync":
			{
				var _p_id = parsed_data[? "id"];
				if (_p_id == global.player_id) then exit;
			
				if (instance_exists(obj_player_dummy))
				{
					with (obj_player_dummy)
					{
						if (p_id != _p_id)
						{
							continue;
						}
						else
						{
							x = parsed_data[? "x"];	
							y = parsed_data[? "y"];
							hspd = parsed_data[? "hspd"];
							vspd = parsed_data[? "vspd"];
						
							//Server relay
							server_relay_data(parsed_data);
							exit;
						}
					}
				
					//If we make it this far, make a new dude. Used when there are more than 2 players!!
					var _p = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", obj_player_dummy);
					_p.p_id = parsed_data[? "id"];
					_p.hspd = parsed_data[? "hspd"];
					_p.vspd = parsed_data[? "vspd"];
				}
				else //Make a new dude here b/c no dude exists!
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
			
				var _p_id = parsed_data[? "id"];
				if (_p_id == global.player_id)
				{
					//The sync is for us, from the host!
					if (instance_exists(obj_player))
					{
						with (obj_player)
						{
							hp = parsed_data[? "hp"];	
							maxHp = parsed_data[? "maxHp"];
						}
					}
				}
				else
				{
					if (instance_exists(obj_player_dummy))
					{
				
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
							drop_item = parsed_data[? "drop_item"];
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
		
			case "item_create":
			{
				if (global.player_id == parsed_data[? "player_id"]) then exit;
			
				var _it = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", obj_item);
				_it.item_id = parsed_data[? "item_id"];
				_it.image_index = parsed_data[? "item_id"];
				_it.speed = parsed_data[? "speed"];
				_it.direction = parsed_data[? "direction"];
				_it.pickup_delay = room_speed; //Toss time!
				_it.friction = parsed_data[? "friction"];
				_it.pickup_delay = parsed_data[? "pickup_delay"];
				_it.alarm[0] = -1; //PLEASE DO NOT GIVE ME 10290 STONE FROM ONE NODE AND BUFFER OVREFLOW THE GAME AGAIN OH MY GOD
			
				server_relay_data(parsed_data);
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
				
				if (global.is_host == true)
				{
					server_relay_data(parsed_data);	
				}
			}
			break;
		
			case "enemy_sync":
			{
				var o_index = parsed_data[? "object_index"];
			
				if (instance_exists(o_index))
				{
					var _o_id = parsed_data[? "id"];
					var _counter = 0;
						
					with (o_index)
					{
						if (object_id == -1)
						{
							//Allow us to assign this very object the new id.
							object_id = _o_id;
						}
						else if (object_id == _o_id)
						{
							x = parsed_data[? "x"];	
							y = parsed_data[? "y"];
							hAccel = parsed_data[? "hAccel"];
							vAccel = parsed_data[? "vAccel"];
							hp = parsed_data[? "hp"];
							break;
						}
						else if (_counter == instance_number(o_index) - 1)
						{
							//Create a new instance
							var _p = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", o_index);
							_p.object_id = parsed_data[? "id"];
							_p.hAccel = parsed_data[? "hAccel"];
							_p.vAccel = parsed_data[? "vAccel"];
							_p.hp = parsed_data[? "hp"];
						}
						
						_counter++;
					}
					show_debug_message("Instance Number: "+string(instance_number(o_index)));
				}
				else
				{
					//Create a new instance
					var _p = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", o_index);
					_p.object_id = parsed_data[? "id"];
					_p.hAccel = parsed_data[? "hAccel"];
					_p.vAccel = parsed_data[? "vAccel"];
					_p.hp = parsed_data[? "hp"];
				}
			}
			break;
		
			case "enemy_sync_asteroid":
			{
				//NOTE: This code is exactly the same as enemy_sync, except hAccel and vAccel are replaced with hspeed and vspeed.
				var o_index = parsed_data[? "object_index"];
			
				if (instance_exists(o_index))
				{
					var _o_id = parsed_data[? "id"];
					var _counter = 0;
						
					with (o_index)
					{
						if (object_id == -1)
						{
							//Allow us to assign this very object the new id.
							object_id = _o_id;
						}
						else if (object_id == _o_id)
						{
							x = parsed_data[? "x"];	
							y = parsed_data[? "y"];
							hspeed = parsed_data[? "hAccel"];
							vspeed = parsed_data[? "hp"];
							break;
						}
						else if (_counter == instance_number(o_index) - 1)
						{
							//Create a new instance
							var _p = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", o_index);
							_p.object_id = parsed_data[? "id"];
							_p.hspeed = parsed_data[? "hAccel"];
							_p.vspeed = parsed_data[? "vAccel"];
							_p.hp = parsed_data[? "hp"];
						}
						
						_counter++;
					}
					show_debug_message("Instance Number: "+string(instance_number(o_index)));
				}
				else
				{
					//Create a new instance
					var _p = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", o_index);
					_p.object_id = parsed_data[? "id"];
					_p.hspeed = parsed_data[? "hAccel"];
					_p.vspeed = parsed_data[? "vAccel"];
					_p.hp = parsed_data[? "hp"];
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
		
			case "bullet_dummy_create":
			{
				if (global.player_id == parsed_data[? "player_id"]) then exit;
			
				var _bu = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", obj_bullet);
				_bu.speed = parsed_data[? "speed"];
				_bu.direction = parsed_data[? "direction"];
				_bu.image_angle = parsed_data[? "image_angle"];
				_bu.objective = parsed_data[? "objective"];
				_bu.alarm[1] = -1;
			
				server_relay_data(parsed_data); //make sure all clients see this!
			}
			break;
			
			default: { successful_parse = false; } break;
		}
	}
	
	return successful_parse;
}

function server_relay_data(data_to_relay)
{
	if (global.player_count > 1 && global.is_host == true)
	{
		send_data(data_to_relay);
	}
}