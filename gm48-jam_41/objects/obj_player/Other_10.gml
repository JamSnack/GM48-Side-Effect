/// @description SYNC PLAYER FUNCTION
if (global.multiplayer == true)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "player_sync";
	_d[? "id"] = global.player_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "hspd"] = hspd;
	_d[? "vspd"] = vspd;
	
	send_data(_d);	
}