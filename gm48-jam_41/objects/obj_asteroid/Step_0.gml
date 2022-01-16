/// @description Insert description here
// You can write your code in this editor
image_angle += speed*rotation*3;

if (place_meeting_fast(hspeed,vspeed,obj_tile,false))
{
	//EXPLODDDEEE
	repeat(25)
	{
		if collision_circle(x,y,global.tile_size*(2*scale),obj_tile,false,false) != noone
		{
			with collision_circle(x,y,global.tile_size*(2*scale),obj_tile,false,false)
			{
				drop_item = false;
				update_tile_light(x,y);
				instance_destroy();
			}
		} else break;
	}
	
	instance_destroy();	
}