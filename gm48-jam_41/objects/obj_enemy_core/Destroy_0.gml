/// @description Insert description here
// You can write your code in this editor
event_inherited();

repeat(floor(maxHp/10)*2)
{
	create_item(choose(ITEMID.item_silver,ITEMID.item_copper,ITEMID.item_iron,ITEMID.item_coal), x, y);
}