/// @description SYNC PLAYER STATS
// You can write your code in this editor
if (global.multiplayer == true)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "player_stats_sync";
	_d[? "id"] = global.player_id;
	_d[? "hp"] = hp;
	_d[? "maxHp"] = maxHp;
	send_data(_d);	
}