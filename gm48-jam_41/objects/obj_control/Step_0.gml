/// @description Insert description here
// You can write your code in this editor
if (game_state == "INIT" && !instance_exists(obj_generator_worm))
{
	
	show_debug_message("##game_state INIT finished. game_state = PLAYER##");
	game_state = "PLAYER";
	instance_create_layer(irandom_range(2000,3000),irandom_range(2000,3000),"Instances",obj_player);
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
time_mil += (1/60);

if (time_mil >= 1)
{
	time_mil = 0;
	time_s += 1;
	
	if (time_s > 60)
	{
		time_s = 0;
		time_m += 1;
	
		if (time_m > 60)
		{
			time_m = 0;
			time_h += 1;
		}
	}
}