// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createServer(port, max_clients)
{
	//Creates a lobby on the relay server
	global.socket = network_create_socket(network_socket_tcp);
	
	var _s = network_connect_raw(global.socket, "127.0.0.1", port);
	
	if (_s < 0)
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
		
		ds_list_add(global.player_name_list, global.player_name); //add playername
		
		lobby_search(0);
	}
	
	/*
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
		
		ds_list_add(global.player_name_list, global.player_name); //add playername
	}
	*/
}

function joinServer(lobby_id)
{
	server_status = "Connecting to server...";
	
	global.socket = network_create_socket(network_socket_tcp);
	
	var _s = network_connect_raw(global.socket, "127.0.0.1", 55555);
	
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
		
		lobby_search(lobby_id);
		//lobby_init_connection();
	}	
}

function send_data(data_map)
{
	if (global.multiplayer == true)
	{
		var json_map = json_encode(data_map);
		//show_debug_message("sending: "+json_map);
		var buff = buffer_create(64, buffer_grow, 1);
	
		buffer_seek(buff, buffer_seek_start, 0);
		var _b = buffer_write(buff, buffer_string, json_map);
	
		if (_b == -1) then show_debug_message("buffer_write failed.");
	
		//show_debug_message(json_map);
		network_send_raw(global.socket, buff, buffer_tell(buff));
			/*if (global.is_host == false)
			{
				network_send_raw(global.socket, buff, buffer_tell(buff));
			}
			else
			{
				for (var i = 0; i < ds_list_size(global.socketlist); i++;)
			    {
					network_send_raw(ds_list_find_value(global.socketlist, i), buff, buffer_tell(buff));
			    }
			}*/
	
		//cleanup
		buffer_delete(buff);
	}
	
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
			case "lobby_init_connection":
			{
				if (global.is_host == true)
				{
					ds_list_add(global.player_name_list, parsed_data[? "name"]);
					sync_lobby();
				}
			}
			break;
			
			case "request_lobby_init_connection":
			{
				lobby_init_connection();
			}
			break;
			
			case "sync_lobby_init_connection":
			{
				//Responsible for updating the client's list of playernames and other info.
				//Expect a list of names.
				if (global.is_host == false)
				{
					ds_list_destroy(global.player_name_list);
					global.player_name_list = ds_list_create();
				
					//Update playernames
					for (var _p = 0; _p < parsed_data[? "pl_size"]; _p++)
					{
						global.player_name_list[| _p] = parsed_data[? string(_p)];
					}
				
					//Update difficulty and world_size
					if (instance_exists(obj_menu_control))
					{
						obj_menu_control.selected_difficulty = parsed_data[? "dif"];	
						obj_menu_control.new_world_size = parsed_data[? "w_size"];
					}
				}
			}
			break;
			
			case "lobby_request_change_name":
			{
				if (global.is_host == true)
				{
					var _old = parsed_data[? "old"];
					var _new = parsed_data[? "new"];
					var _indx = ds_list_find_index(global.player_name_list, _old);
					global.player_name_list[| _indx] = _new;
				
					sync_lobby();
				}
			}
			break;
			
			case "lobby_change_world_info":
			{
				if (global.is_host == false)
				{
					if (instance_exists(obj_menu_control))
					{
						with(obj_menu_control)
						{
							new_world_size = parsed_data[? "size"];
						}
					}
				}
			}
			break;
			
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
				var _id = parsed_data[? "o_id"];
				var _x = parsed_data[? "x"];
				var _y = parsed_data[? "y"];
				
				var t_pos = 
				{
					pos_x : _x,
					pos_y : _y
				};
				
				instance_activate_region(_x-34,_y-34,68,68,true); //-32 pixels and then some
			
				var _t = collision_point(_x,_y,obj_tile,false,false);
				var _success = false;
				
				if (_t != noone)
				{
					with (_t)
					{
						if (item_id == parsed_data[? "type"])
						{
							drop_item = false;//parsed_data[? "drop_item"];
							_success = true;
							instance_destroy();	
						}
					}
				}
				
				if (_success == false)
				{
					ds_list_add(global.recently_destroyed_tiles, t_pos);	
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
		
			case "wave_time_sync":
			{
				if (instance_exists(obj_control))
				{
					with (obj_control)
					{
						time_mil = parsed_data[? "tml"];
						time_m = parsed_data[? "tm"];
						time_h = parsed_data[? "th"];
						difficulty = parsed_data[? "dif"];

						//Play music
						var ran_volume = choose(1,0);
						if (audio_sound_get_gain(music_drums) != ran_volume)
						{
							audio_sound_gain(music_drums,ran_volume,1000*2);
						}
						
						if (difficulty > 5)
						{
							if (audio_sound_get_gain(music_enemy) != 1)
							{
								audio_sound_gain(music_enemy,1,1000*2);
								music_delay = room_speed*28;
							}	
						}
						
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
				var _o_id = parsed_data[? "id"];
				var o_index = parsed_data[? "o_indx"];
				
				//ignore packets from recently destroyed objects.
				if (ds_list_find_index(global.recently_destroyed_objects, _o_id) == -1)
				{
					if (instance_exists(o_index))
					{
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
								hAccel = parsed_data[? "hspd"];
								vAccel = parsed_data[? "vspd"];
								hp = parsed_data[? "hp"];
								break;
							}
							else if (_counter == instance_number(o_index) - 1)
							{
								//Create a new instance
								var _p = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", o_index);
								_p.object_id = parsed_data[? "id"];
								_p.hAccel = parsed_data[? "hspd"];
								_p.vAccel = parsed_data[? "vspd"];
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
						_p.hAccel = parsed_data[? "hspd"];
						_p.vAccel = parsed_data[? "vspd"];
						_p.hp = parsed_data[? "hp"];
					}
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
						show_debug_message("DESTROY ME: "+string(_id)+", ME: "+string(object_id));
						if (object_id == _id)
						{
							show_debug_message("ME: "+string(object_id)+" DED");
							instance_destroy();
							
							//Recently destroyed objects.
							ds_list_add(global.recently_destroyed_objects, object_id);
							
							if (ds_list_size(global.recently_destroyed_objects) > 15)
							{
								ds_list_delete(global.recently_destroyed_objects, 0);	
							}
							
							break;
						}
						else 
						{
							continue;
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
			
			case "init_asteroid":
			{
				with (obj_asteroid)
				{
					if (parsed_data[? "o_id"] == object_id)
					{
						scale = parsed_data[? "scl"];
						image_xscale = scale;
						image_yscale = scale;
						maxHp = 1+scale;
						break;
					}
				}
			}
			break;
			
			case "existence_bounce":
			{
				var kill_me = true;
				
				if (parsed_data[? "p_id"] == global.player_id)
				{
					with (parsed_data[? "o_index"])
					{
						if (parsed_data[? "o_id"] == object_id)
						{
							//The instance exists!
							if (global.is_host == true)
							{
								server_relay_data(parsed_data);
							}
							else kill_me = false;
							
							break;
						}
						
						if (kill_me)
						{
							instance_destroy();	
						}
					}
				}
			}
			break;
			
			case "core_update":
			{
				//NOTE: Having an excess of resource XP is responsible for leveling up, 
				//the host WILL NOT send a level up packet. Make sure core XP is synchronized BEFORE
				//scr_update_core() is called.
				
				//We've received a core update
				if (instance_exists(obj_core))
				{
					with (obj_core)
					{						
						core_hp_xp = parsed_data[? "hp_xp"];
						core_turret_rate_xp = parsed_data[? "t_r_xp"];
						core_turret_damage_xp = parsed_data[? "t_d_xp"];
						core_turret_hp_xp = parsed_data[? "t_h_xp"];
						scr_update_core();
					}
				}
			}
			break;
			
			case "core_hp_sync":
			{
				if (instance_exists(obj_core))
				{
					with (obj_core)
					{
						hp = parsed_data[? "hp"];
						alarm[0] = parsed_data[? "alarm_time"];
					}
				}
			}
			break;
			
			case "core_upgrade_request":
			{
				if (global.is_host == true)
				{
					//We've received an upgrade request!
					server_relay_data(parsed_data);
				}
				else if (parsed_data[? "p_id"] == global.player_id)
				{
					global.inventory[parsed_data[? "upgrade"]] -= 1;
					update_inventory();
					
					var _d = ds_map_create();
					_d[? "cmd"] = "core_upgrade_success";
					_d[? "upgrade"] = parsed_data[? "upgrade"];
					send_data(_d);
				}
			}
			break;
			
			case "core_upgrade_success":
			{
				if (global.is_host == true)
				{
					scr_apply_core_upgrade(parsed_data[? "upgrade"]);
					scr_update_core();
				}
			}
			break;
			
			case "init_turret":
			{
				if (parsed_data[? "p_id"] != global.player_id)
				{
					var _tu = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", parsed_data[? "o_indx"]);
					
					var o_id = parsed_data[? "o_id"];
					_tu.object_id = o_id;
						
				}
				
				server_relay_data(parsed_data);	//send this turret to other clients.
			}
			break;
			
			case "request_structure_placement":
			{
				if (global.is_host == true)
				{
					instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", parsed_data[? "structure"]);	
					
					var _d = ds_map_create();
					_d[? "cmd"] = "structure_successfully_placed";
					_d[? "p_id"] = parsed_data[? "p_id"];
					_d[? "structure"] = parsed_data[? "structure"];
					send_data(_d);
				}
			}
			break;
			
			case "structure_successfully_placed":
			{
				if (global.player_id == parsed_data[? "p_id"])
				{
					//structure_deduct_cost(parsed_data[? "structure"]);
				}
			}
			break;
			
			default: { successful_parse = false; } break;
		}
		
		//Map cleanup
		ds_map_destroy(parsed_data);
	}
	
	//return
	return successful_parse;
}

function server_relay_data(data_to_relay)
{
	if (global.is_host == true)
	{
		send_data(data_to_relay);
	}
}

function network_destroy_connections()
{
	//Disconenct chat message
	var _str = global.player_name +" has disconnected.";
	send_chat(_str);
	
	
	//Actually disconnect
	network_destroy(global.socket);
	
	//Clear out socket list
	if (global.is_host == true)
		ds_list_clear(global.socketlist);
	
	//Clear out other lists
	ds_list_clear(global.player_name_list);
	ds_list_clear(global.recently_destroyed_tiles);
	ds_list_clear(global.recently_destroyed_objects);
	
	//Reset variables
	global.player_count = 0;
	global.is_host = false;
	global.multiplayer = false;
	
	if (instance_exists(obj_menu_control))
		with (obj_menu_control) server_status = "";
}