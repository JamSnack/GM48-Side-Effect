/// @description Insert description here
// You can write your code in this editor
//-SPIN
image_angle -= 0.5;

//Death
if (hp <= 0) then instance_destroy();


//Multiplayer
if (global.is_host == true)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "enemy_sync";
	_d[? "id"] = object_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "hAccel"] = 0;
	_d[? "vAccel"] = 0;
	_d[? "object_index"] = object_index;
	_d[? "hp"] = hp;
	send_data(_d);
}