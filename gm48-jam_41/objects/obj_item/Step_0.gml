/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_player))
{
	var distance_to_player = distance_to_object(obj_player);
	
	if (distance_to_player < global.tile_size*5)
	{
		motion_add(point_direction(x,y,obj_player.x,obj_player.y),1);
	
		image_angle += hspeed;
	
		if (distance_to_player < 2)
		{
			global.inventory[item_id] += 1;
			obj_player.items_held += 1;
			instance_destroy();
		}
	}
}