/// @description Insert description here
// You can write your code in this editor
_alpha = 1;
begin_sequence = false;
menu_section = "START";
server_status = "";
menu_animation_timer = 0;
change_playername = false;
new_playername = "";
change_playername_delay = 0
old_playername = global.player_name;
new_world_size = 3500; //default room_width for Room1

//Option sliders
max_world_size = 3500*2;
min_world_size = 2000;
drag_world_size = false; //Whether or not the option slider is being dragged.


//play some musicals
audio_play_sound(Eternal_Boredom,10,true);

//Networkin timeout
network_set_config(network_config_connect_timeout, 5000);

//Buttons
lobby_button_exit_index = 0;