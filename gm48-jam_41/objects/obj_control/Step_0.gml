/// @description Insert description here
// You can write your code in this editor
if (game_state == "INIT")
{
	repeat(100)
	{
		generate_world(game_state);
		
		if (game_state == "FINAL")
			break;
	}
	
	if (game_state == "FINAL")
		generate_world(game_state);
}
else if (game_state == "FINAL" && !instance_exists(obj_generator_worm))
{
	show_debug_message("##game_state INIT finished. game_state = PLAYER##");
	game_state = "PLAYER";
	instance_create_layer(irandom_range((game_world_width/4),game_world_width-(game_world_width/4)),irandom_range(game_world_height/4,game_world_height-(game_world_height/4)),"Instances",obj_player);
	
	//Place enemy camps
	var _amt = 1;
	
	if (game_difficulty == 0)
		_amt = 0;
	else if (game_difficulty > 2)
		_amt += (game_difficulty-2);
	
	repeat(_amt)
	{
		var _xx = obj_player.x; //we gotta start somehwere :eyes:
		var _yy = obj_player.y;
		var _success = true;
		
		//init dist_from_nearest_core
		var dist_from_nearest_core = 0;
		
		//loop for a spawn point
		var _breaker = 0;
		while ((point_distance(_xx,_yy,obj_player.x,obj_player.y) < global.tile_size*26) && dist_from_nearest_core < global.tile_size*2) 
		{	
			if (instance_exists(obj_enemy_core))
			{
				var _g = instance_nearest(_xx, _yy, obj_enemy_core);
				dist_from_nearest_core = point_distance(_xx, _yy, _g.x, _g.y);
			}
			
			_xx = choose( irandom_range( 0, (game_world_width/4)-64 ), irandom_range( game_world_width-(game_world_width/4)+64, game_world_width-64 ) );
			_yy = choose( irandom_range( 64, (game_world_height/4)-64 ), irandom_range(-(game_world_height/4)+game_world_height+64, game_world_height-64) );
			
			_breaker += 1;
			
			if (_breaker > 200) 
			{
				_success = false;
				break;
			}
		}
			
		if (_success == true)
		{
			instance_create_layer( _xx, _yy, "Instances", obj_enemy_core);
			//show_debug_message("SPAWNED A CORE");
		}
	}
}	

//---CONTROL THE GAME---
if (game_state != "PLAYER")
	exit;

//Hud Text
if hud_text_delay <= 0 && (hud_text_buffer != "" && hud_text != hud_text_buffer)
{
	hud_text_delay = hud_text_delay_set;
	
	var char = string_char_at(hud_text_buffer,string_length(hud_text)+1);
	hud_text += char;
	hud_text = scr_fitText(hud_text, 73);
	
	if (hud_text == hud_text_buffer)
	{
		alarm[0] = room_speed*4;	
	}
}

hud_text_delay -= 1;

//Timer
function sync_wave()
{
	//Synchronize the timer in multiplayer games
	if (global.is_host == true)
	{
		
		//Ds map implementation
		var _d = ds_map_create();
		_d[? "cmd"] = "wave_time_sync";
		_d[? "tml"] = time_mil;
		_d[? "tm"] = time_m;
		_d[? "th"] = time_h;
		_d[? "dif"] = difficulty;
		send_data(_d);
	}
}

if (global.game_over == false) && ((global.multiplayer == false && global.game_paused == false) || (global.multiplayer == true))
{
	time_mil += (1/60);

	if (time_mil >= 60)
	{
		time_mil = 0;
		time_m += 1;
	
		if (time_m >= 60)
		{
			time_m = 0;
			time_h += 1;
		}
	}

	//A wave a minute!
	if ( ((global.is_host == true && global.multiplayer == true) || global.multiplayer == false) && wave_delay <= 0 && game_difficulty != 0)
	{
		sync_wave();
		
		difficulty += 1;
		
		if (difficulty > 5-game_difficulty)
		{
			repeat( (global.player_count) + floor(difficulty/(8-game_difficulty)) )
			{
				instance_create_layer(choose(-64,game_world_width+64),choose(-64,game_world_height+64),"Instances",obj_enemy_01);
			}
		}
	
		wave_delay = clamp((room_speed*(90-(difficulty*floor(game_difficulty/2)))), room_speed*10, room_speed*90);
	
		if (difficulty >= 5)
		{
			repeat(difficulty+(floor((difficulty*game_difficulty)/2)))
			{
				var _top = choose(1,2);
			
				if _top == 1
				{
					instance_create_layer(choose( -128, game_world_width+128 ), choose(-64,game_world_height+64), "Instances", obj_asteroid);
				}
				else
				{
					instance_create_layer(choose( -128, game_world_width+128 ), game_world_height/2, "Instances", obj_asteroid);
				}
			}
			
			if (audio_sound_get_gain(music_enemy) != 1)
			{
				audio_sound_gain(music_enemy,1,1000*2);
				music_delay = room_speed*28;
			}
		}
		
		var ran_volume = choose(1,0);
		
		if (audio_sound_get_gain(music_drums) != ran_volume)
		{
			audio_sound_gain(music_drums,ran_volume,1000*2);
		}

		show_debug_message("#Wave spawned#Difficulty: "+string(difficulty)+"#enemies: "+string(instance_number(obj_enemy_01))+"#asteroids: "+string(instance_number(obj_asteroid)));
	}

	wave_delay -= 1;
}


if (global.game_paused == true)
{
	var mouse_result = ui_button_check_gui(spr_button_exit, 4, 4, 690-64*2,250, mb_left);
	
	exit_index = mouse_result;
	
	if (mouse_result == MB_RELEASED)
	{
		room_goto(rm_menu);
		audio_stop_all();
		network_destroy_connections();
	}
}


//Randomly scale in background music
if (music_delay <= 0 && irandom(300) == 1)
{
	if (audio_sound_get_gain(music_bkg) != 1)
	{
		audio_sound_gain(music_bkg,1,1000*4);
	}
	else
	{
		audio_sound_gain(music_bkg,0,1000*4);
	}
	
	audio_sound_gain(music_enemy,0,1000*8);
	
	music_delay = room_speed*32;
}
else if (music_delay > 0)
{
	music_delay -= 1;	
}


//GAME OVER
if (global.game_over == true && keyboard_check_released(vk_escape))
{
	//GO TO THE MENU.
	room_goto(rm_menu);
	audio_stop_all();
	
	if (global.multiplayer == true) then network_destroy_connections();
}

//Tile culling
if (instance_exists(obj_player))
{
	if (point_distance(obj_player.x, obj_player.y, player_buffer_x, player_buffer_y) > global.tile_size*2)
	{
		player_buffer_x = obj_player.x;
		player_buffer_y = obj_player.y;
		
		//Deactivate all tiles
		instance_deactivate_object(obj_tile);
		
		//Reactivate tiles around the player and important creatures
		var _boundary = global.tile_size*24;
		instance_activate_region(player_buffer_x-_boundary, player_buffer_y-_boundary, _boundary*2, _boundary*2, true);
		
		
		//This should happen because we just deactivated all tiles and we need to make sure enemies don't clip into things
		if (global.is_host == true)
		{
			with (ENEMY)
			{
				instance_activate_region(x-_boundary/4, y-_boundary/4, _boundary/2, _boundary/2, true);
			}
		}
		
		//Check for tiles to destroy
		var _size = ds_list_size(global.recently_destroyed_tiles);
		
		if (ds_exists(global.recently_destroyed_tiles, ds_type_list) && _size > 0)
		{
			for (var _i = 0; _i < _size; _i++)
			{
				var t_pos = global.recently_destroyed_tiles[| _i];
				
				if (is_struct(t_pos))
				{
					var _t = collision_point(t_pos.pos_x, t_pos.pos_y, obj_tile, false, false);
				
					if ( _t != noone)
					{
						with (_t)
						{
							drop_item = false; //Assume this
							show_debug_message("DESTROYED: "+string(t_pos.pos_x)+":"+string(t_pos.pos_y));
							instance_destroy();
						}
					
						ds_list_delete(global.recently_destroyed_tiles, _i);
					}
				} else ds_list_delete(global.recently_destroyed_tiles, _i);
			}
		}
	}
}
