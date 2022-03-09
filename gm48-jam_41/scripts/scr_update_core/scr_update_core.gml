// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//THIS IS THE LEVEL UP SCRIPT
function scr_update_core()
{
	with (obj_core)
	{
		//Shove the shitty netcode into the script:
		if (global.is_host == true)
		{
			var _d = ds_map_create();
			_d[? "cmd"] = "core_update";
			_d[? "hp_xp"] = core_hp_xp;
			_d[? "t_r_xp"] = core_turret_rate_xp;
			_d[? "t_d_xp"] = core_turret_damage_xp;
			_d[? "t_h_xp"] = core_turret_hp_xp;
			send_data(_d);
		}
	
		//NOW we level up (important to send large XP values since we don't send the level):
		if (core_hp_xp >= core_hp_xp_max)
		{
			core_hp_xp_max *= 2;
			core_hp_xp = 0;
				
			maxHp += 15;
			event_user(0);
		}
		else if (core_turret_rate_xp >= core_turret_rate_xp_max)
		{
			core_turret_rate_xp_max *= 2;
			core_turret_rate_xp = 0;
				
			core_turret_rate = lerp(core_turret_rate,0,.2);
			event_user(0);
		}
		else if (core_turret_damage_xp >= core_turret_damage_xp_max)
		{
			core_turret_damage_xp_max *= 2;
			core_turret_damage_xp = 0;
				
			core_turret_damage += 1;
			event_user(0);
		}
		else if (core_turret_hp_xp >= core_turret_hp_xp_max)
		{
			core_turret_hp_xp_max *= 2;
			core_turret_hp_xp = 0;
				
			core_turret_hp += 8;
			event_user(0);
		}
	}
}