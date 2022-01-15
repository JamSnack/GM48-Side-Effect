/// @description Insert description here
// You can write your code in this editor
if drop_item == false then exit;

var _i = instance_create_layer(x,y,"Instances", obj_item);
_i.item_id = item_id;
_i.image_index = item_id;

update_tile_light(x,y);