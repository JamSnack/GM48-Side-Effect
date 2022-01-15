// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function generate_world()
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
	}
}