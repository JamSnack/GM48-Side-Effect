/// @description Insert description here
// You can write your code in this editor
draw_set_alpha(_alpha);
draw_set_halign(fa_center);
draw_set_font(fnt_terminal_grotesque);
draw_set_color(c_white);
draw_text_transformed(display_get_gui_width()/2,50,"STROID RAIDER",4,4,0);
draw_text_transformed(display_get_gui_width()/2,175,"Created for the 41st GM48 Game Jam - Theme: Side Effects.\nCredits: JamSnack - Developer, FiskalFinance - Playtester",0.6,0.6,0);
draw_text_transformed(display_get_gui_width()/2,400,"Press any key to continue.",2,2,0);
draw_set_alpha(1-_alpha);
draw_text_transformed(display_get_gui_width()/2,350,"Generating world...",2,2,0);