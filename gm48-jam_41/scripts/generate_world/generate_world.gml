// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function generate_world(game_state)
{
	switch game_state
	{
		case "INIT":
		{
			var world_width = ceil(room_width/global.tile_size);
			var world_height = ceil(room_height/global.tile_size);
	
	
	
			//Fill the room with tiles!
			for (_i = 0; _i < world_width*world_height; _i++)
			{
				var column = floor(_i/world_width);
				var pos_x = (_i*global.tile_size)-(column*world_width*global.tile_size);
				var pos_y = (column*global.tile_size);
		
				var _inst = instance_create_layer(pos_x,pos_y,"Instances",obj_tile);
				_inst.item_id = ITEMID.item_stone;
				_inst.image_index = ITEMID.item_stone;
				_inst.hp = get_tile_hp(ITEMID.item_stone);
			}
	
	
			//Place dirt and ore!
			
			function generate_worm(repeat_amt,tile_placing,life_span,radius,is_ore)
			{
				repeat(repeat_amt)
				{
					var ore_worm = instance_create_layer(irandom_range(0,room_width),irandom_range(0,room_height),"Instances",obj_generator_worm);
					ore_worm.tile_placing = tile_placing;
					ore_worm.life_span = life_span;
					ore_worm.radius = radius;
					ore_worm.is_ore = is_ore;
				}
			}
			
			generate_worm(7, ITEMID.item_dirt, irandom_range(15,20), 3, false);
			
			//-- Uncommon
			generate_worm(9, ITEMID.item_obsidian, irandom_range(6,11), 1, true);
			generate_worm(9, ITEMID.item_aluminum, irandom_range(6,11), 1, true);
			
			//-- Common
			generate_worm(17, ITEMID.item_coal, irandom_range(7,12), 2, true);
			generate_worm(17, ITEMID.item_copper, irandom_range(7,12), 2, true);
			generate_worm(17, ITEMID.item_iron, irandom_range(7,12), 2, true);
			generate_worm(17, ITEMID.item_silver, irandom_range(7,12), 2, true);
			
			//-- Rare
			generate_worm(7, ITEMID.item_ruby, irandom_range(6,11), 1, true);
			generate_worm(7, ITEMID.item_gold, irandom_range(6,11), 1, true);
			generate_worm(2, ITEMID.item_diamond, 1, 1, true);
			
			//-- Finite
			generate_worm(1, ITEMID.item_phynite, 1, 1, true);
			
			//Place enemy camps
			repeat(1)
			{
				instance_create_layer( choose( irandom_range( 0, (room_width/4)-64 ), irandom_range( room_width-(room_width/4)+64, room_width-64 ) ), choose( irandom_range( 64, (room_height/4)-64 ), irandom_range(-(room_height/4)+room_height+64, room_height-64) ), "Instances", obj_enemy_core);	
			}

		}
		break;
	}
}