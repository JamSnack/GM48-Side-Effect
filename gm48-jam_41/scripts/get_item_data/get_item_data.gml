// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_item_data(ITEMID)
{
	var data = array_create(2);
	data[0] = "NAME";
	data[1] = "Description.";
	data[2] = "Positive Effect.";
	data[3] = "Negative Effect";
	
	switch ITEMID
	{
		case ITEMID.item_coal: { data[1] = "Coal Ore"; data[2] = "Witty coal description here."; data[3] = "Increases Movement Speed"; data[4] = "Decreases Weight Limit"; } break;
		case ITEMID.item_copper: { data[1] = "Copper Ore"; data[2] = "Witty copper description here."; data[3] = "Increases Mining Rate"; data[4] = "Decreases Attack Rate"; } break;
		case ITEMID.item_iron: { data[1] = "Iron Ore"; data[2] = "Witty iron description here."; data[3] = "Increases Weight Limit"; data[4] = "Decreases Agility"; } break;
		case ITEMID.item_stone: { data[1] = "Stone"; data[2] = "Witty stone description here."; data[3] = ""; data[4] = "Takes up space in your inventory."; } break;
		case ITEMID.item_dirt: { data[1] = "Dirt"; data[2] = "Witty dirt description here."; data[3] = ""; data[4] = "Takes up space in your inventory."; } break;
	}
	
	return data;
}