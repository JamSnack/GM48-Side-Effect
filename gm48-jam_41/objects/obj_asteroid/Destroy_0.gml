/// @description Insert description here
// You can write your code in this editor
event_inherited();
play_sound_local(snd_big_splosion,x,y);

if (global.is_host && drop_item)
{
	var _r = 1 + irandom(2+maxHp);
	repeat(_r)
	{
		create_item(choose(ITEMID.item_stone, ITEMID.item_stone, ITEMID.item_stone, ITEMID.item_stone, ITEMID.item_stone, ITEMID.item_coal, ITEMID.item_copper, ITEMID.item_iron, ITEMID.item_silver), x, y);
	}
}