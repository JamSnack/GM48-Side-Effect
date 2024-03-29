/// @description Insert description here
// You can write your code in this editor
image_angle += _speed*rotation*3;

//Death
if (hp <= 0)
{
	instance_destroy();
}

//- Death bouncema
if (global.multiplayer == false && global.is_host == true) && (x == xprevious && y == yprevious)
{
	if (multiplayer_death_counter > 60)
	{
		//check_for_existance();
		instance_destroy();
		multiplayer_death_counter = 0;
	}
	
	multiplayer_death_counter++;
}
else multiplayer_death_counter = 0;

if (global.is_host == false && global.multiplayer == true) then exit;

if (place_meeting_fast(hAccel,vAccel,obj_tile,false))
{
	//EXPLODDDEEE
	repeat(25)
	{
		if collision_circle(x,y,global.tile_size*(scale)*2,obj_tile,false,false) != noone
		{
			with collision_circle(x,y,global.tile_size*(scale)*2,obj_tile,false,false)
			{
				drop_item = false;
				update_tile_light(x,y);
				instance_destroy();
			}
		} else break;
	}
	
	instance_destroy();	
}

if place_meeting_fast(hAccel,vAccel,PLAYER_TARGET,false)
{
	var _list = ds_list_create();
	collision_circle_list(x,y,global.tile_size*(scale)*2,PLAYER_TARGET,false,false,_list,false);
	
	for(var _i = 0;_i < ds_list_size(_list); _i++)
	{
		var _inst = ds_list_find_value(_list, _i);
		hurt_instance(_inst, scale*2);
		show_debug_message("Please hurt: "+string(_inst));
	}
	
	ds_list_destroy(_list);
	instance_destroy();
}


//Position update
x += hAccel;
y += vAccel;

//Multiplayer!
if (global.is_host == true && move_delay <= 0)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "enemy_sync";
	_d[? "id"] = object_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "hspd"] = hAccel;
	_d[? "vspd"] = vAccel;
	_d[? "o_indx"] = object_index;
	_d[? "hp"] = hp;
	send_data(_d);
	
	if (alarm[0] > 59*room_speed) //send a couple of these for consistency's sake
		init_asteroid_for_multiplayer();
		
	move_delay = 10;
}
else move_delay--;

//Instance culling
activate_region(2);