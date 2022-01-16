/// @description Insert description here
// You can write your code in this editor

repeat(floor(maxHp/10)*2)
{
	var _i = instance_create_layer(x,y,"Instances", obj_item);
	var _itd = choose(ITEMID.item_silver,ITEMID.item_copper,ITEMID.item_iron,ITEMID.item_coal);
	
	_i.item_id = _itd;
	_i.image_index = _itd;
	_i.pickup_delay = room_speed*3;
	_i.speed = 3;
	_i.direction = irandom(360);
}