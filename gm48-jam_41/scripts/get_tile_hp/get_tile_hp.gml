// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_tile_hp(item_id)
{
	var _hp = 0;
	
	switch item_id
	{
		case ITEMID.item_silver:
		case ITEMID.item_coal:
		case ITEMID.item_copper:
		case ITEMID.item_iron: { _hp = 2; } break;
		case ITEMID.item_stone: { _hp = 1; } break;
		case ITEMID.item_dirt: { _hp = 0.25; } break;
		
		case ITEMID.item_obsidian:
		case ITEMID.item_aluminum: { _hp = 3; } break;

		case ITEMID.item_gold:
		case ITEMID.item_ruby: { _hp = 4; } break;
		
		case ITEMID.item_diamond: { _hp = 5; } break;
		
		case ITEMID.item_phynite: { _hp = 8; } break;
	}
	
	return _hp;
}