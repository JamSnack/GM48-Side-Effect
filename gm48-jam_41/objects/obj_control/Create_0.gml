/// @description Insert description here
// You can write your code in this editor
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
generate_world();