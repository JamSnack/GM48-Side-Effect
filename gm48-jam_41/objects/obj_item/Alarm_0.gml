/// @description MULTIPLAYER - Sync item spawns
var _d = ds_map_create();
_d[? "cmd"] = "item_create";
_d[? "x"] = x;
_d[? "y"] = y;
_d[? "item_id"] = item_id;
_d[? "player_id"] = global.player_id;
_d[? "direction"] = direction;
_d[? "speed"] = speed;
_d[? "friction"] = friction;
_d[? "pickup_delay"] = pickup_delay-1;
send_data(_d);