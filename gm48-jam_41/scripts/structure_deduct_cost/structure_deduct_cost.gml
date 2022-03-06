// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function structure_deduct_cost(structure_index)
{
	var _success = false;	

	
	switch structure_index
	{
		case obj_core_turret:
		{
			if (global.inventory[ITEMID.item_stone] >= 12 && global.inventory[ITEMID.item_copper] >= 3 && global.inventory[ITEMID.item_iron] >= 3)
			{
				global.inventory[ITEMID.item_stone] -= 12;	
				global.inventory[ITEMID.item_copper] -= 3;
				global.inventory[ITEMID.item_iron] -= 3;
				
				_success = true;
			}
		}
		break;
		
		case obj_red_turret:
		{
			if (global.inventory[ITEMID.item_aluminum] >= 4 && global.inventory[ITEMID.item_ruby] >= 3 && global.inventory[ITEMID.item_obsidian] >= 2)
			{
				global.inventory[ITEMID.item_aluminum] -= 4;	
				global.inventory[ITEMID.item_ruby] -= 3;
				global.inventory[ITEMID.item_obsidian] -= 2;
				
				_success = true;
			}
		}
		break;
	}
	
	if _success == true
	{
		update_inventory();
	}
	else
	{
		obj_control.hud_text_buffer += "\nNot enough resources.\n"	
	}
	
	return _success;
}