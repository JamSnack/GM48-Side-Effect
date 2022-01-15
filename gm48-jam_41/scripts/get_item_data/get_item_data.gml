// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_item_data(item_id)
{
	var data = array_create(2);
	data[0] = "NAME";
	data[1] = "Description.";
	data[2] = "Positive Effect.";
	data[3] = "Negative Effect";
	
	switch item_id
	{
		case ITEMID.item_coal: { data[0] = "Coal Ore"; data[1] = "Witty coal description here."; data[2] = "Increases Max Movement Speed"; data[3] = "Decreases Weight Limit"; } break;
		case ITEMID.item_copper: { data[0] = "Copper Ore"; data[1] = "Witty copper description here."; data[2] = "Increases Mining Speed"; data[3] = "Decreases Attack Speed"; } break;
		case ITEMID.item_iron: { data[0] = "Iron Ore"; data[1] = "Witty iron description here."; data[2] = "Increases Weight Limit"; data[3] = "Decreases Max Movement Speed"; } break;
		case ITEMID.item_stone: { data[0] = "Stone"; data[1] = "Useful for simple base upgrades."; data[2] = ""; data[3] = ""; } break;
		case ITEMID.item_dirt: { data[0] = "Dirt"; data[1] = ""; data[2] = ""; data[3] = "Takes up space in your inventory."; } break;
	}
	
	return data;
}