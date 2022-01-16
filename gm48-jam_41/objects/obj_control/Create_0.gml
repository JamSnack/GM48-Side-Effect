/// @description Insert description here
// You can write your code in this editor
randomize();
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
generate_world(game_state);

//Text log
hud_text_buffer = "";
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

//Audio flip
audio_listener_set_orientation(0,0,0,-1,0,1,0);