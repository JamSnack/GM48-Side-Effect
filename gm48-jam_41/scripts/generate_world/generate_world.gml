// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function generate_world(game_state)
{
	switch game_state
	{
		case "INIT":
		{
			//Fill the room with tiles
			var column = floor(id_counter/tiles_in_world_width);
			var pos_x = (id_counter*global.tile_size)-(column*tiles_in_world_width*global.tile_size);
			var pos_y = (column*global.tile_size);
		
			var _inst = instance_create_layer(pos_x,pos_y,"Instances",obj_tile);
			_inst.item_id = ITEMID.item_stone;
			_inst.image_index = ITEMID.item_stone;
			_inst.hp = get_tile_hp(ITEMID.item_stone);
			_inst.object_id = id_counter;
			id_counter++;
			
			//Set final game state
			if (id_counter > tiles_in_world_height*tiles_in_world_width)
			{
				obj_control.game_state = "FINAL";
				break;
			}
		}
		break;
		
		case "FINAL":
		{
			
			//Place dirt and ore!
			generate_worm(scale_distribution(7), ITEMID.item_dirt, irandom_range(15,20), 3, false);
			
			//-- Rare
			generate_worm(scale_distribution(2), ITEMID.item_ruby, irandom_range(6,11), 1, true);
			generate_worm(scale_distribution(2), ITEMID.item_gold, irandom_range(6,11), 1, true);
			
			//-- Uncommon
			generate_worm(scale_distribution(6), ITEMID.item_obsidian, irandom_range(6,11), 1, true);
			generate_worm(scale_distribution(6), ITEMID.item_aluminum, irandom_range(6,11), 1, true);
			
			//-- Common
			generate_worm(scale_distribution(15), ITEMID.item_silver, irandom_range(7,12), 2, true);
			generate_worm(scale_distribution(15), ITEMID.item_coal, irandom_range(7,12), 2, true);
			generate_worm(scale_distribution(15), ITEMID.item_iron, irandom_range(7,12), 2, true);
			generate_worm(scale_distribution(15), ITEMID.item_copper, irandom_range(7,12), 2, true);
		
			//-- Uncommon again
			generate_worm(scale_distribution(4), ITEMID.item_obsidian, irandom_range(6,11), 1, true);
			generate_worm(scale_distribution(4), ITEMID.item_aluminum, irandom_range(6,11), 1, true);
			
			//-- Rare again
			generate_worm(scale_distribution(4), ITEMID.item_ruby, irandom_range(6,11), 1, true);
			generate_worm(scale_distribution(4), ITEMID.item_gold, irandom_range(6,11), 1, true);
			generate_worm(scale_distribution(2), ITEMID.item_diamond, 1, 1, true);
			
			//-- Finite
			generate_worm(scale_distribution(1), ITEMID.item_phynite, 1, 1, true);

			//Destroy the main menu control object
			if (instance_exists(obj_menu_control))
			{
				with (obj_menu_control) instance_destroy();
			}
		}
		break;
	}
}