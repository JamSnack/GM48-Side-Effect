/// @description Insert description here
// You can write your code in this editor
draw_set_alpha(_alpha);

switch (menu_section)
{
	case "START":
	{
		draw_set_halign(fa_center);
		draw_set_font(fnt_terminal_grotesque);
		draw_set_color(c_white);
		draw_text_transformed(display_get_gui_width()/2,50,"STROID RAIDER",4,4,0);
		draw_text_transformed(display_get_gui_width()/2,175,"Created for the 41st GM48 Game Jam - Theme: Side Effects.\nCredits: JamSnack - Developer, FiskalFinance - Playtester",0.6,0.6,0);
		draw_text_transformed(display_get_gui_width()/2,400,"Press any key to continue.",2,2,0);
	}
	break;
	
	case "GAMEMODE":
	{
		draw_set_halign(fa_center);
		draw_set_font(fnt_terminal_grotesque);
		draw_set_color(c_white);
		draw_text_transformed(display_get_gui_width()/2,50,"SELECT GAMEMODE",4,4,0);
		draw_text_transformed(display_get_gui_width()/2,400,"Press for 'Q' for multiplayer.\nPress 'W' for Singleplayer.\nPress 'E' to go back.",1,1,0);
	}
	break;
	
	case "LOBBY":
	{
		draw_set_alpha(_alpha);
		draw_set_halign(fa_center);
		draw_set_font(fnt_terminal_grotesque);
		draw_set_color(c_white);
		draw_text_transformed(display_get_gui_width()/2,50,"STROID RAIDER: TOGETHER",3,3,0);
		
		if server_status == ""
		{
			draw_text_transformed(display_get_gui_width()/2,175,"Press F1 to start a server. Press F2 to join one.",0.6,0.6,0);
		}
		else if (global.is_host == true)
		{
			draw_text_transformed(display_get_gui_width()/2,175,"Press Q to start the game.",0.6,0.6,0);
			draw_text_transformed(display_get_gui_width()/2,400,server_status+"\nPlayers: "+string(global.player_count)+"/3",2,2,0);
		}
		else draw_text_transformed(display_get_gui_width()/2,400,server_status,2,2,0);
	}
	break;
	
}

draw_set_alpha(1-_alpha);
draw_text_transformed(display_get_gui_width()/2,350,"Generating world...",2,2,0);