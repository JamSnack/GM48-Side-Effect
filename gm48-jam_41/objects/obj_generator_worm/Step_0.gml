/// @description Insert description here
// You can write your code in this editor
while (life_span > 0)
{
	var _list = ds_list_create();
	collision_circle_list(x,y,radius*global.tile_size,obj_tile,false,false,_list,false);
	
	var _tile = tile_placing;
	
	for(_z = 0; _z < ds_list_size(_list); _z++)
	{
		with ds_list_find_value(_list,_z)
		{
			var _inst = instance_create_layer(x,y,"Instances",obj_tile);
			_inst.item_id = _tile;
			_inst.alarm[0] = 1;
			
			drop_item = false;
			
			instance_destroy();
		}
	}
	
	life_span -= 1;
	
	var h_step = lengthdir_x(speed,direction);
	var v_step = lengthdir_y(speed,direction);
	
	if (x + h_step < 0 || x + h_step > room_w) then h_step = -h_step;
	if (y + v_step < 0 || y + v_step > room_h) then v_step = -v_step;
	
	x += h_step;
	y += v_step;
	
	radius += choose(0,0,0,1,-1);
	
	if (is_ore == true)
	{
		radius = 1;
	}
	else radius = clamp(radius,2,6);
	
	direction += irandom_range(-10,10);
	speed += random_range(-1,1);
}


instance_destroy();


