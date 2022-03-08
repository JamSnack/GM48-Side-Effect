// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function activate_region(tile_distance)
{
	if (point_distance(x, y, buffer_x, buffer_y) > global.tile_size*tile_distance)
	{
		buffer_x = x;
		buffer_y = y;
		
		//Deactivate all tiles
		
		//Reactivate tiles around the player and important creatures
		var _boundary = global.tile_size*5;
		instance_activate_region(buffer_x-_boundary, buffer_y-_boundary, _boundary*2, _boundary*2, true);
	}
}