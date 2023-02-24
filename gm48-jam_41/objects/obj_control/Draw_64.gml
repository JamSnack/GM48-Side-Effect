/// @description Insert description here
// You can write your code in this editor

//Draw loading status
if (game_state == "INIT")
{
	draw_text(20, 20, "Loading: " + string(id_counter/(tiles_in_world_height*tiles_in_world_width)*100) + "%");
}
else if (game_state == "FINAL")
	draw_text(20, 20, "Loading: Placing ore...");

//Draw the hud text
draw_set_colour(c_white);

if (hud_text != "")
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_font(fnt_terminal_grotesque);
	draw_text_transformed(670,660,hud_text,1.25,1.25,0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	//show_debug_message(hud_text);
}

//Draw timer
var _str = string(time_h)+":"+string(time_m)+":"+string(time_mil);
draw_text(1200,700,_str);

//Paused
if (global.game_paused == true)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text_transformed(690,200,"Game Paused",2,2,0);
	draw_text_transformed(690,650,"Difficulty: "+difficulty_to_string(game_difficulty),1.5,1.5,0);
	draw_sprite_ext(spr_button_exit,exit_index,690-64*2,250,4,4,0,c_white,1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text_transformed(20,200,"F11 - Toggle Fullscreen\nF - Toggle Inventory\nE - Interact with the Core.\nWASD - Movement\nLeft Click - Mining laser\nRight Click - Shoot projectile\n\nScroll through many resources\nin the inventory using the mousewheel.",0.8,0.8,0);
}

if (global.game_over == true)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text_transformed(690,700,"Press escape to return to the main menu.",1.5,1.5,0);
	draw_text_transformed(690,200,"You survived for:\n"+_str,2,2,0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}