/// @description Insert description here
// You can write your code in this editor
if (game_state == "INIT" && !instance_exists(obj_generator_worm))
{
	
	show_debug_message("##game_state INIT finished. game_state = PLAYER##");
	game_state = "PLAYER";
	instance_create_layer(irandom_range((room_width/4),room_width-(room_width/4)),irandom_range(room_height/4,room_height-(room_height/4)),"Instances",obj_player);
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
		alarm[0] = room_speed*2;	
	}
}

hud_text_delay -= 1;

//Timer
if global.game_over == false
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
	if (wave_delay <= 0)
	{
		difficulty += 1;
	
		repeat(difficulty mod 2)
		{
			instance_create_layer(choose(-64,room_width+64),choose(-64,room_height+64),"Instances",obj_enemy_01);
		}
	
		wave_delay = clamp((room_speed*(90-difficulty)), room_speed*60, room_speed*90);
	
		if (difficulty >= 5)
		{
			repeat(difficulty+2)
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
		}
	
		show_debug_message("#Wave spawned#Difficulty: "+string(difficulty)+"#enemies: "+string(instance_number(obj_enemy_01))+"#asteroids: "+string(instance_number(obj_asteroid)));
	}

	wave_delay -= 1;
}
