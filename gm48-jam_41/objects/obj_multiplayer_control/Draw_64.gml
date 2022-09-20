/// @description Insert description here
// You can write your code in this editor
if (global.networking_debug == true)
{
	var width = display_get_gui_width();
	
	draw_set_halign(fa_right);
	draw_text(width-60,10,"Players connected: "+string(global.player_count));
	draw_text(width-60,40,"Lobby ID: "+string(global.lobby_id));
	draw_text(width-60,70,"Player ID: "+string(global.player_id));
	draw_text(width-60,100,"Sent: "+string(global.packets_sent));
	draw_text(width-60,120,"Recv: "+string(global.packets_recv));
	//draw_text(width-60,33,"Ping: "+string(display_ping));
}

draw_set_halign(fa_left);