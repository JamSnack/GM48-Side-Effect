/// @description Insert description here
// You can write your code in this editor

if (begin_sequence == false)
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
	}
}

//Start the game!
else if (begin_sequence = true)
{
	_alpha -= 0.01;
	
	if _alpha <= -0.5 then room_goto(Room1);
}