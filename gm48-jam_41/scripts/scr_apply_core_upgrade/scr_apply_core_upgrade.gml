// Script assets have changed for v2.3.0 see

//FOR USE IN obj_core;
//Removes items and applies XP. Separate from scr_update_core, which communicates the change with other players and levels things up.

function scr_apply_core_upgrade(_upgrade)
{		
	with (obj_core)
	{
		switch _upgrade
		{
			case ITEMID.item_stone: { core_hp_xp += 1;} break;
			case ITEMID.item_coal: { core_turret_rate_xp += 1;} break;
			case ITEMID.item_iron: { core_turret_damage_xp += 1;} break;
			case ITEMID.item_silver: { core_turret_hp_xp += 1;} break;
		}
	}
}