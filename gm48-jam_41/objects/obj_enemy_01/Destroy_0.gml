/// @description Insert description here
// You can write your code in this editor


// Inherit the parent event
event_inherited();


//Drop loot
if (global.is_host)
{
	if (irandom(2) == 1)
	{
		var _r = irandom(4)-1; 
		repeat(_r)
		{
			create_item(choose(ITEMID.item_stone,ITEMID.item_silver,ITEMID.item_copper,ITEMID.item_iron,ITEMID.item_coal), x, y);
		}
	}
}
