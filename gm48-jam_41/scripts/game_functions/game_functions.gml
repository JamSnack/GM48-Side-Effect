// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function hurt_instance(inst_id, damage)
{
	if (instance_exists(inst_id))
	{	
		with inst_id
		{	
			if (object_index == obj_player_dummy && visible == false) || (object_index == obj_player && dead == true)
			{
				if (distance_to_object(obj_core) < 4)
				{
					hurt_instance(obj_core, damage);
				}
				
				break;
			}
			
			hp -= damage;
		
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
}