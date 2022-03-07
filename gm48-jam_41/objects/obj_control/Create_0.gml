/// @description Insert description here
// You can write your code in this editor
random_set_seed(global.game_seed);
global.tile_size = 32;

//ITEMID
enum ITEMID
{
	nil,
	// -- Common
	item_coal, //Increases movement speed but decreases weight limit.
	item_iron, //Increases weight limit but decreases agility.
	item_copper, //Increases mining tick_rate but decreases attack tick_rate;
	item_stone,
	item_dirt,
	item_silver, //Decreases mining tick_rate but increases attack tickrate;
	
	// -- Uncommon
	item_aluminum,
	item_obsidian,
	
	// -- rare
	item_ruby,
	item_gold,
	
	// -- super rare
	item_diamond,
	
	// -- OMEGA RARE
	item_phynite,
	
	last
}

//Inventory
global.inventory = array_create(ITEMID.last,0);

//World GEN :)
game_state = "INIT";
id_counter = 1;
game_world_width = obj_menu_control.new_world_size;
game_world_height = game_world_width;
generate_world(game_state);

//Text log
hud_text_buffer = "Pause the game with 'ESC' to review controls.";
hud_text = "";
hud_text_delay_set = 2;
hud_text_delay = hud_text_delay_set;

//Timer and wave stuff
difficulty = 0;
wave_delay = room_speed*1;//room_speed*60*1;
time_mil = 0; //Time in miliseconds
time_m = 0; //Time in minutes;
time_h = 0; //Time in hours;

//Oh yeah
global.game_over = false;
global.game_paused = false;

//Pause
exit_index = 0;

//Audio init
audio_falloff_set_model(audio_falloff_linear_distance);
audio_listener_set_orientation(0,0,0,-1,0,1,0);

//Music
music_delay = room_speed*28;

music_drums = audio_play_sound(snd_time_to_move,4,true);
audio_sound_gain(music_drums,0,0);
music_bkg = audio_play_sound(snd_cosmic_background_radiation,4,true);
audio_sound_gain(music_bkg,0,0);
music_enemy = audio_play_sound(snd_trouble_arrives,4,true);
audio_sound_gain(music_enemy,0,0);