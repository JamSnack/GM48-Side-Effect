/// @description Insert description here
// You can write your code in this editor
if (game_state == "INIT" && !instance_exists(obj_generator_worm))
{
	
	show_debug_message("##game_state INIT finished. game_state = PLAYER##");
	game_state = "PLAYER";
	instance_create_layer(irandom_range((room_width/4),room_width-(room_width/4)),irandom_range(room_height/4,room_height-(room_height/4)),"Instances",obj_player);
	
	//Place enemy camps
	repeat(1)
	{
		var _xx = obj_player.x;
		var _yy = obj_player.y;
		
		var _breaker = 0;
		
		while (point_distance(_xx,_yy,obj_player.x,obj_player.y) < global.tile_size*26) 
		{	
			_xx = choose( irandom_range( 0, (room_width/4)-64 ), irandom_range( room_width-(room_width/4)+64, room_width-64 ) );
			_yy = choose( irandom_range( 64, (room_height/4)-64 ), irandom_range(-(room_height/4)+room_height+64, room_height-64) );
			
			_breaker += 1;
			
			if (_breaker > 75) then break;
		}
		
				
		instance_create_layer( _xx, _yy, "Instances", obj_enemy_core);	
	}
}

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
		var _d = ds_map_create();
		_d[? "cmd"] = "wave_time_sync";
		_d[? "time_mil"] = time_mil;
		_d[? "time_m"] = time_m;
		_d[? "time_h"] = time_h;
		send_data(_d);
	}
}

if (global.multiplayer == false && global.game_over == false && global.game_paused == false) || (global.multiplayer == true)
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
	if (global.is_host == true && wave_delay <= 0)
	{
		sync_wave();
		
		difficulty += 1;
		
		if (difficulty > 3)
		{
			repeat((difficulty mod (2+global.player_count-1)))
			{
				instance_create_layer(choose(-64,room_width+64),choose(-64,room_height+64),"Instances",obj_enemy_01);
			}
		}
	
		wave_delay = clamp((room_speed*(90-difficulty)), room_speed*60, room_speed*90);
	
		if (difficulty >= 5)
		{
			repeat(difficulty+(floor(difficulty/2)))
			{
				var _top = choose(1,2);
			
				if _top == 1
				{
					instance_create_layer(choose( -128, room_width+128 ), choose(-64,room_height+64), "Instances", obj_asteroid);
				}
				else
				{
					instance_create_layer(choose( -128, room_width+128 ), room_height/2, "Instances", obj_asteroid);
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
else if (global.game_paused == true)
{
	var _dx = device_mouse_x_to_gui(0);
	var _dy = device_mouse_y_to_gui(0);
	
	if (point_in_rectangle(_dx,_dy,690-64*2,250,690-64*2+64*4,250+32*4))
	{
		exit_index = 1;	
		
		if (mouse_check_button_pressed(mb_left))
		{
			exit_index = 2;	
		}
		
		if (mouse_check_button_released(mb_left))
		{
			//GO TO THE MENU.
			room_goto(rm_menu);
			audio_stop_all();
		}
		
	}
	else
	{
		exit_index = 0;	
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
}