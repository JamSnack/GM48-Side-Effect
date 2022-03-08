/// @description Insert description here
// You can write your code in this editor
var disp_width = display_get_gui_width();
var disp_height = display_get_gui_height();

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
		var _center = display_get_gui_width()/2;
		
		draw_set_alpha(_alpha);
		
		draw_set_halign(fa_center);
		draw_set_font(fnt_terminal_grotesque);
		draw_set_color(c_white);
		
		if (server_status == "" || string_char_at(server_status, 1) == "F")
		{
			draw_text_transformed(_center,50,"STROID RAIDER: TOGETHER",2,2,0);
			draw_text_transformed(_center,175,"Press F1 to start a server. Press F2 to join one.",0.6,0.6,0);
			draw_text_transformed(display_get_gui_width()/2,400,server_status,2,2,0);
		}
		else 
		{			
			if (global.is_host == true)
			{
				draw_text_transformed(_center,display_get_gui_height()-30,"Press Q to start the game.",0.6,0.6,0);
				draw_text_transformed(_center,60,server_status+"\nPlayers: "+string(global.player_count),1,1,0);
			} 
			else draw_text_transformed(display_get_gui_width()/2,400,server_status,2,2,0);
			
			//Draw playerships and usernames!
			var player_amt = ds_list_size(global.player_name_list);
			
			for (var _i = 0; _i < player_amt; _i++)
			{
				var _xx = _center-((player_amt-1)*60)+(120*_i);
				draw_sprite_ext(spr_player,0,_xx,250,2,2,(_i*45)+menu_animation_timer,c_white,_alpha);
				draw_text_transformed(_xx,300,global.player_name_list[| _i],0.6,0.6,0);
				
				if (_i == 0)
					draw_sprite(spr_ui_host, 0, _xx-(string_width(global.player_name_list[| _i])/2)+5,310); //host crown
			}
			
			//Draw world-gen information
			var _ws = string(ceil(new_world_size/32)); //MN: 32 is global.tile_size
			
			draw_rectangle_color(_center-220,340,_center+220,480,c_black,c_black,c_black,c_black,false);
			draw_rectangle_color(_center-150,398,_center+150,402,c_gray,c_gray,c_gray,c_gray,false);
			var world_size_drag_x = (_center-150)+((300)*((new_world_size-min_world_size)/(max_world_size-min_world_size)));
			//world_size_drag_x = clamp(world_size_drag_x, _center-150, _center+150);
			draw_sprite(spr_ui_slider,0,world_size_drag_x,400);
			draw_text(_center,350,"World Size:\n\n\n"+_ws+"x"+_ws);
			draw_text(_center,500,"Difficulty:");
			
			//Name and other infor
			draw_set_halign(fa_left);
			draw_text(5,10,"Name: "+global.player_name);
			draw_text(5,35,"Press 'Enter' to change.");
		}
	}
	break;
	
}

//Playername change!
if (change_playername == true)
{
	draw_set_halign(fa_center);
	draw_set_font(fnt_terminal_grotesque);
	draw_set_color(c_white);
	
	draw_set_alpha(0.8);
	draw_rectangle_color(0,0,disp_width,disp_height,c_black,c_black,c_black,c_black,false);
	draw_set_alpha(1);
	
	draw_text_transformed(disp_width/2,(disp_height/2)-100,"Enter name:\n"+new_playername,2,2,0);
	draw_text_transformed(disp_width/2,(disp_height/2)+30,"Press 'Enter' to confirm.",1,1,0);
}

draw_set_alpha(1-_alpha);
draw_set_halign(fa_center);
draw_text_transformed(display_get_gui_width()/2,350,"Generating world...",2,2,0);