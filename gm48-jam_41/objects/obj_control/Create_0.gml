/// @description Insert description here
// You can write your code in this editor
randomize();
global.tile_size = 32;

//ITEMID
enum ITEMID
{
	nil,
	item_coal, //Increases movement speed but decreases weight limit.
	item_iron, //Increases weight limit but decreases agility.
	item_copper, //Increases mining tick_rate but decreases attack tick_rate;
	item_stone,
	item_dirt,
	
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

//Timer
time_mil = 0; //Time in miliseconds
time_s = 0; //Time in seconds;
time_m = 0; //Time in minutes;
time_h = 0; //Time in hours;