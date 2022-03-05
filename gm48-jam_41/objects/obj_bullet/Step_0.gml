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
			hp -= _d;
			
			if (object_index == obj_player_dummy)
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