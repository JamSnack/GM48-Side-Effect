/// @description Insert description here
// You can write your code in this editor
if drop_item == false then exit;

var _i = instance_create_layer(x,y,"Instances", obj_item);
_i.item_id = item_id;
_i.image_index = item_id;
_i.object_id = object_id;

update_tile_light(x,y);

if (global.multiplayer == true)
{
	//Send tile_destruction.
	//Send tile_type.
	var _d = ds_map_create();
	_d[? "cmd"] = "tile_destroy";
	_d[? "type"] = item_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	send_data(_d);
}