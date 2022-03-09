// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function generate_world(game_state)
{
	switch game_state
	{
		case "INIT":
		{
			var world_width = ceil(game_world_width/global.tile_size);
			var world_height = ceil(game_world_height/global.tile_size);
	
	
	
			//Fill the room with tiles!
			for (_i = 0; _i < world_width*world_height; _i++)
			{
				id_counter++;
				var column = floor(_i/world_width);
				var pos_x = (_i*global.tile_size)-(column*world_width*global.tile_size);
				var pos_y = (column*global.tile_size);
		
				var _inst = instance_create_layer(pos_x,pos_y,"Instances",obj_tile);
				_inst.item_id = ITEMID.item_stone;
				_inst.image_index = ITEMID.item_stone;
				_inst.hp = get_tile_hp(ITEMID.item_stone);
				_inst.object_id = id_counter;
			}
	
	
			//Place dirt and ore!
			
			function generate_worm(repeat_amt,tile_placing,life_span,radius,is_ore)
			{
				repeat(repeat_amt)
				{
					var ore_worm = instance_create_layer(irandom_range(0,game_world_width),irandom_range(0,game_world_height),"Instances",obj_generator_worm);
					ore_worm.tile_placing = tile_placing;
					ore_worm.life_span = life_span;
					ore_worm.radius = radius;
					ore_worm.is_ore = is_ore;
					ore_worm.room_h = game_world_height;
					ore_worm.room_w = game_world_width;
				}
			}
			
			function scale_distribution(base_rate)
			{
				//Base_rate is how many worms we want to spawn in a normal (110x110) world.
				if (ceil(game_world_width/global.tile_size) > 110)
				{
					return base_rate + floor(ceil(game_world_width/global.tile_size)/90);
				}
				else return base_rate;
			}
			
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


			//Destroy the menu control object
			if (instance_exists(obj_menu_control))
			{
				with (obj_menu_control) instance_destroy();
			}
		}
		break;
	}
}