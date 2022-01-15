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
	
			repeat(4)
			{
				var dirt_worm = instance_create_layer(irandom_range(0,room_width),irandom_range(0,room_height),"Instances",obj_generator_worm);
				dirt_worm.tile_placing = ITEMID.item_dirt;
			}
			
			repeat(15)
			{
				var ore_worm = instance_create_layer(irandom_range(0,room_width),irandom_range(0,room_height),"Instances",obj_generator_worm);
				ore_worm.tile_placing = choose(ITEMID.item_coal,ITEMID.item_iron,ITEMID.item_copper);
				ore_worm.life_span = irandom_range(7,12);
				ore_worm.radius = 1;
				ore_worm.is_ore = true;
			}
		}
		break;
	}
}