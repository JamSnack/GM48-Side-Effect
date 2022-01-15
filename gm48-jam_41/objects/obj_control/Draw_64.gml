/// @description Insert description here
// You can write your code in this editor
//Draw the hud text
if (hud_text != "")
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_colour(c_white);
	draw_set_font(fnt_terminal_grotesque);
	draw_text_transformed(670,660,hud_text,1.25,1.25,0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	show_debug_message(hud_text);
}

//Draw timer
var _str = "AGgggH"//string(time_h)+":"+string(time_m)+":"+string(time_s)+"."+string(time_mil);
draw_text(display_get_gui_width()-string_width(_str),display_get_gui_height()-3,_str);