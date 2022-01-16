/// @description Insert description here
// You can write your code in this editor
image_angle += speed*rotation*3;

if (place_meeting_fast(hspeed,vspeed,obj_tile,false))
{
	//EXPLODDDEEE
	repeat(25)
	{
		if collision_circle(x,y,global.tile_size*(scale),obj_tile,false,false) != noone
		{
			with collision_circle(x,y,global.tile_size*(scale),obj_tile,false,false)
			{
				drop_item = false;
				update_tile_light(x,y);
				instance_destroy();
			}
		} else break;
	}
	
	instance_destroy();	
}
else if place_meeting_fast(hspeed,vspeed,PLAYER,false)
{
	var _list = ds_list_create();
	collision_circle_list(x,y,global.tile_size*(scale),PLAYER,false,false,_list,false);
	
	for(_i=0;_i<ds_list_size(_list);_i++)
	{
		var _inst = ds_list_find_value(_list,_i);
		
		if (instance_exists(_inst))
		{
			var _dam = scale*2;
			
			with _inst
			{
				_inst.hp -= _dam;	
			}
		}
	}
	
	instance_destroy();
}

if (hp <= 0)
{
	instance_destroy();	
}