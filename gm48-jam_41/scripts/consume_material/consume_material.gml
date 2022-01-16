// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Consume an item from the inventory and apply a side-effect.

function consume_material(item_id)
{	
	//Apply the effect
	switch (item_id)
	{
		case ITEMID.item_coal: { agility = lerp(agility, 2, 0.1); weight_tolerance = round(weight_tolerance - (45/weight_tolerance)); } break;
		case ITEMID.item_iron: {  weight_tolerance = round(weight_tolerance + (45/weight_tolerance)); agility = lerp(agility, 0.71, 0.1); } break;
		case ITEMID.item_silver: { mining_rate += (20/mining_rate); attack_rate -= (room_speed/attack_rate) } break;
		case ITEMID.item_copper: { mining_rate -= (20/mining_rate); attack_rate += (room_speed/attack_rate) } break;
		
		case ITEMID.item_aluminum: { mining_damage = lerp(mining_damage, 3, 0.1); attack_damage = lerp(attack_damage, 0, 0.1);} break;
		case ITEMID.item_obsidian: { mining_damage = lerp(mining_damage, 0, 0.1); attack_damage = lerp(attack_damage, 3, 0.1);} break;
		
		case ITEMID.item_ruby: { maxHp += 1; hp_regen_rate += 40; } break;
		case ITEMID.item_gold: { maxHp -= 1; hp_regen_rate -= 40; } break;
		
		case ITEMID.item_diamond: { hp_regen_amt = lerp(hp_regen_amt,5,0.25); } break;
		
		case ITEMID.item_phynite: { agility += 1.5; } break;
	}
	
	update_inventory();
	audio_play_sound(snd_eat,3,false);
}