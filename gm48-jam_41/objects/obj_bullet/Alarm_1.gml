/// @description MULTIPLAYER - BULLET DUMMY
if (global.multiplayer == true)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "bullet_dummy_create";
	_d[? "speed"] = speed;
	_d[? "direction"] = direction;
	_d[? "image_angle"] = image_angle;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "player_id"] = global.player_id;
	_d[? "objective"] = objective;
	send_data(_d);
}