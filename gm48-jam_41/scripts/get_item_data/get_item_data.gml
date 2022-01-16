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
		case ITEMID.item_coal: { data[0] = "Coal Ore"; data[1] = "Good for fuel, but takes up space on the ship."; data[2] = "Increases Acceleration"; data[3] = "Decreases Weight Limit"; } break;
		case ITEMID.item_copper: { data[0] = "Copper Ore"; data[1] = ""; data[2] = "Increases Mining Speed"; data[3] = "Decreases Attack Speed"; } break;
		case ITEMID.item_iron: { data[0] = "Iron Ore"; data[1] = ""; data[2] = "Increases Weight Limit"; data[3] = "Decreases Acceleration"; } break;
		case ITEMID.item_stone: { data[0] = "Stone"; data[1] = "Useful for simple base upgrades."; data[2] = ""; data[3] = ""; } break;
		case ITEMID.item_dirt: { data[0] = "Dirt"; data[1] = "Not useful UNLESS you are an earthworm."; data[2] = ""; data[3] = "Takes up space in your inventory."; } break;
		case ITEMID.item_silver: { data[0] = "Silver Ore"; data[1] = ""; data[2] = "Increases Attack Speed"; data[3] = "Decreases Mining Speed"; } break;
		case ITEMID.item_aluminum: { data[0] = "Aluminum"; data[1] = ""; data[2] = "Increases Mining Damage"; data[3] = "Decreases Attack Damage"; } break;
		case ITEMID.item_obsidian: { data[0] = "Obsidian"; data[1] = ""; data[2] = "Increases Attack Damage"; data[3] = "Decreases Mining Damage"; } break;
		case ITEMID.item_ruby: { data[0] = "Ruby"; data[1] = ""; data[2] = "Increases Max HP"; data[3] = "Decreases HP Regeneration Rate"; } break;
		case ITEMID.item_gold: { data[0] = "Gold"; data[1] = ""; data[2] = "Increases HP Regeneration Rate"; data[3] = "Decreases Max HP"; } break;
		case ITEMID.item_diamond: { data[0] = "Diamond"; data[1] = ""; data[2] = "Increases HP Regenerated"; data[3] = ""; } break;
		case ITEMID.item_phynite: { data[0] = "Phynite"; data[1] = "There's only a finite amount!"; data[2] = "Greatly Increases Acceleration"; data[3] = ""; } break;
	}
	
	return data;
}