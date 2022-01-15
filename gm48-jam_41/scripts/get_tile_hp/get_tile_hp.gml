// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_tile_hp(item_id)
{
	var _hp = 0;
	
	switch item_id
	{
		case ITEMID.item_coal: { _hp = 5; } break;
		case ITEMID.item_copper: { _hp = 5; } break;
		case ITEMID.item_iron: { _hp = 5; } break;
		case ITEMID.item_stone: { _hp = 2; } break;
		case ITEMID.item_dirt: { _hp = 1; } break;
	}
	
	return _hp;
}