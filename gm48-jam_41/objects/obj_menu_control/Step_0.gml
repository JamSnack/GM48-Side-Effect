/// @description Insert description here
// You can write your code in this editor

if (begin_sequence == false && change_playername == false)
{
	if (keyboard_key != 0 && menu_section == "START")
	{
		menu_section = "GAMEMODE";
	}
	else if (menu_section == "GAMEMODE")
	{
		if (keyboard_check_released(ord("Q")))
		{
			//Enter multiplayer screen
			menu_section = "LOBBY";
		}
		else if (keyboard_check_released(ord("W")))
		{
			//Start a single-player game
			begin_sequence = true;
		}
	}
	else if (menu_section == "LOBBY")
	{
		if (global.multiplayer = false) //Pre-Lobby stuff
		{
			if (keyboard_check_released(vk_f1))
			{
				createServer(get_integer("Enter server port.", 55555), 2);
			}
			else if (keyboard_check_released(vk_f2))
			{
				joinServer(get_integer("Enter lobby id.", 1000));	
			}
		}
		else if (global.is_host == true)
		{
			if (keyboard_check_released(ord("Q")))
			{
				begin_sequence = true;
				randomise(); //Randomise the world seed
				var rng_seed = random_get_seed();
				global.game_seed = rng_seed;
			
				var _d = ds_map_create();
				_d[? "cmd"] = "generate_world";
				_d[? "seed"] = rng_seed;
				send_data(_d);
			}
			else if (mouse_check_button(mb_left))
			{
				var _dx = device_mouse_x_to_gui(0);
				var _dy = device_mouse_y_to_gui(0);
				var _center = display_get_gui_width()/2;
				var world_size_drag_x = (_center-150)+((300)*((new_world_size-min_world_size)/(max_world_size-min_world_size)));
				//world_size_drag_x = clamp(world_size_drag_x, _center-150, _center+150);
				
				if (drag_world_size == false)
				{
					
					var _yy = 400;
					
					if (point_in_rectangle(_dx,_dy,world_size_drag_x-8,_yy-2,world_size_drag_x+8,_yy+2))
					{
						drag_world_size = true;
					}
				}
				else if (drag_world_size == true)
				{
					var _c2 = _center+150;
					var _c1 = _center-150;
					var _dist = point_distance(0,0,_c1,0);
					
					new_world_size = (((_dx-_dist)/(_c2-_dist))*min_world_size*2)+min_world_size; //GOOD LUCK WITH THESE MAGIC NUMBERS! I HAD NO FUCKING IDEA WHAT THEY MEANT WHILE I WAS TYPING THEM >:(
					new_world_size = clamp(new_world_size, min_world_size, max_world_size);
					
					show_debug_message(world_size_drag_x);
				}
			}
			else
			{
				drag_world_size = false;
			}
		}
		
		menu_animation_timer++;
		
		//Buttons
		var lobby_button_exit = ui_button_check_gui(spr_ui_button, 2, 1, 4, display_get_gui_height()-40, mb_left);
		lobby_button_exit_index = lobby_button_exit;
		
		if (lobby_button_exit == MB_RELEASED)
		{
			menu_section = "START";
			network_destroy_connections();
		}
		
		
		// - Difficulty
		if (global.is_host)
		{
			var _wid = sprite_get_width(spr_ui_button)*2.25; //2.25 = x_sc
		
			for (var _i = difficulty_min; _i <= difficulty_max; _i++)
			{
				var dif_x = (28 + (display_get_gui_width()/2) - (_wid*difficulty_max) + (_wid+30)*_i);
				var difficulty_buttons = ui_button_check_gui(spr_ui_button, 2.25, 1.25, dif_x, 550, mb_left);
			
				if (difficulty_buttons == MB_RELEASED)
				{
					selected_difficulty = _i;
					//sync_lobby();
				}
			}
		}
	}
}

//Playername logic
if (change_playername == true && change_playername_delay < 0)
{	
	
	if (keyboard_check(vk_backspace))
	{
		new_playername = string_delete(new_playername, string_length(new_playername), 1);
		change_playername_delay = 5;
		keyboard_lastchar = "";
	} 
	else if (keyboard_check_pressed(vk_enter))
	{
		if (new_playername != "")
		{
			change_playername = false;
			old_playername = global.player_name;
			global.player_name = new_playername;
		
			with (obj_multiplayer_control) { refresh_lobby_names(); }

			if (global.is_host == false)
			{
				var _d = ds_map_create();
				_d[? "cmd"] = "lobby_request_change_name";
				_d[? "new"] = new_playername;
				_d[? "old"] = old_playername;
				send_data(_d);
			}
		
			new_playername = "";
		}
	}
	else if (string_length(new_playername) < 16 && keyboard_lastkey != vk_backspace)
	{
		if (keyboard_lastchar != "")
		{
			new_playername += keyboard_lastchar;
			keyboard_lastchar = "";
			change_playername_delay = 2;
		}	
	}
}
else if (keyboard_check_pressed(vk_enter) && menu_section == "LOBBY" && global.multiplayer == true)
{
	change_playername = true;
	keyboard_lastchar = "";
}

//Start the game!
else if (begin_sequence = true && room == rm_menu)
{
	_alpha -= 0.01;
	
	if _alpha <= -0.5 then room_goto(Room1);
	
	change_playername = false;
}

//Sync the lobby
if (mouse_check_button_released(mb_left))
{
	sync_lobby();
}

//Delay!
change_playername_delay--;