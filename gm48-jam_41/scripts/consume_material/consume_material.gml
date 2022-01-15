// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Consume an item from the inventory and apply a side-effect.

function consume_material(item_id)
{	
	//Apply the effect
	switch (item_id)
	{
		case ITEMID.item_coal: { max_speed += (4/max_speed); weight_tolerance = round(weight_tolerance - (45/weight_tolerance)); } break;
		case ITEMID.item_copper: { mining_rate -= (20/mining_rate); attack_rate += (room_speed/attack_rate) } break;
		case ITEMID.item_iron: {  weight_tolerance = round(weight_tolerance + (45/weight_tolerance)); max_speed -= (4/max_speed) } break;
	}
}