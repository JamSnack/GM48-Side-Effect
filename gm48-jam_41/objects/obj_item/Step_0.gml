/// @description Insert description here
// You can write your code in this editor
if (instance_exists(PLAYER) && pickup_delay <= 0)
{
	var nearest_player = instance_nearest(x,y,PLAYER);
	var distance_to_player = distance_to_object(nearest_player);
	
	if (distance_to_player < global.tile_size*2 || player_lock != noone)
	{
		player_lock = nearest_player;
		motion_add(point_direction(x,y,nearest_player.x,nearest_player.y),1);
	
		image_angle += hspeed;
	
		if (distance_to_player < 2)
		{
			instance_destroy();
		}
	}
}
else if (pickup_delay > 0)
{
	pickup_delay -= 1;
	
	//Collision
	if (speed != 0)
	{
		image_angle += ((hspeed)+(vspeed))*2;
	
		if (place_meeting_fast(hspeed,0,OBSTA,false)) { hspeed = 0; };
		if (place_meeting_fast(0,vspeed,OBSTA,false)) { vspeed = 0; };
	}
}

//Multipalyer item sync
if (global.multiplayer == true && global.is_host == true && x != xprevious && y != yprevious)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "item_sync";
	_d[? "id"] = object_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	send_data(_d);
}