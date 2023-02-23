/// @description Insert description here
// You can write your code in this editor
//-SPIN
image_angle -= 0.5;

//Death
if (hp <= 0) then instance_destroy();


//Multiplayer
if (global.is_host == true && move_delay <= 0)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "enemy_sync";
	_d[? "id"] = object_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "hspd"] = 0;
	_d[? "vspd"] = 0;
	_d[? "o_indx"] = object_index;
	_d[? "hp"] = hp;
	send_data(_d);
	
	move_delay = 10;
}
else move_delay--;