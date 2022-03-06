/// @description Insert description here
// You can write your code in this editor

if (place_meeting_fast(hspeed,vspeed,obj_tile,false)) { instance_destroy(); }
else if (instance_exists(objective) && place_meeting_fast(hspeed,vspeed,objective,false))
{	
	if ((global.multiplayer == true && global.is_host == true) || global.multiplayer == false)
	{
		var _d = damage;
	
		with instance_nearest(x,y,objective)
		{	
			if (object_index == obj_player_dummy && visible == false) || (object_index == obj_player && dead == true)
			{
				if (distance_to_object(obj_core) < 6)
				{
					other.objective = obj_core;
				}
				
				exit;
			}
			
			hp -= _d;
		
			if (object_index == obj_core || object_index == obj_core_turret || object_index == obj_red_turret)
			{
				var _d = ds_map_create();
				_d[? "cmd"] = "structure_stats_sync";
				_d[? "id"] = object_id;
				_d[? "hp"] = hp;
				_d[? "maxHp"] = maxHp;
				send_data(_d);
			}
			else if (object_index == obj_player_dummy)
			{
				var _d = ds_map_create();
				_d[? "cmd"] = "player_stats_sync";
				_d[? "id"] = p_id;
				_d[? "hp"] = hp;
				_d[? "maxHp"] = maxHp;
				send_data(_d);
			}
		}
	}
	
	instance_destroy();
}