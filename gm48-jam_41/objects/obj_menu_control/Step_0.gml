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
		if (global.multiplayer = false)
		{
			if (keyboard_check_released(vk_f1))
			{
				createServer(get_integer("Enter server port.", 1337), 2);
			}
			else if (keyboard_check_released(vk_f2))
			{
				joinServer(get_string("Enter target IP address.","127.0.0.1"), get_integer("Enter server port.", 1337));	
			}
		}
		else if (global.is_host == true && keyboard_check_released(ord("Q")))
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
		
		menu_animation_timer++;
	}
}

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
				_d[? "cmd"] = "lobby_change_name";
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
else if (begin_sequence = true)
{
	_alpha -= 0.01;
	
	if _alpha <= -0.5 then room_goto(Room1);
	
	change_playername = false;
}

//Delay!
change_playername_delay--;