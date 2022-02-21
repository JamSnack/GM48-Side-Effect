/// @description Insert description here
// You can write your code in this editor
if (global.multiplayer == true && obj_control.game_state == "PLAYER")
{
	//Send tile_destruction.
	//Send tile_type.
	var _d = ds_map_create();
	_d[? "cmd"] = "tile_destroy";
	_d[? "type"] = item_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "drop_item"] = false; //Item spawns in other clients will be determined by the item_create command insinde the obj_item create event
	send_data(_d);
}

if drop_item == false then exit;

var _i = instance_create_layer(x,y,"Instances", obj_item);
_i.item_id = item_id;
_i.image_index = item_id;
_i.object_id = object_id;

update_tile_light(x,y);