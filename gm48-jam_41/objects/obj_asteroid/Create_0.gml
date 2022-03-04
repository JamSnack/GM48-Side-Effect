/// @description Insert description here
// You can write your code in this editor
rotation = choose(1,-1);
direction = point_direction(x,y,obj_core.x,obj_core.y);
direction += irandom_range(-15,15);

image_speed = 0;

scale = choose(1,2,3);
_speed = 4-scale;
hAccel = lengthdir_x(_speed,direction);
vAccel = lengthdir_y(_speed,direction);

image_xscale = scale;
image_yscale = scale;

maxHp = 1+scale;
hp = maxHp;

counter = 0;
object_id = get_object_id();

function init_asteroid_for_multiplayer()
{
	if (global.is_host == true)
	{
		var _d = ds_map_create();
		_d[? "cmd"] = "init_asteroid";
		_d[? "scale"] = scale;
		_d[? "object_id"] = object_id;
		send_data(_d);
	}
}