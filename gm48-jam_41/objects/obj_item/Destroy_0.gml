/// @description Dish items to where they due!
// You can write your code in this editor
if (global.is_host == true && instance_exists(player_lock))
{
	if (player_lock.object_index == obj_player)
	{
		global.inventory[item_id] += 1;
			
		update_inventory();
		_sn = audio_play_sound(snd_true_blip,1,false);
		audio_sound_pitch(_sn,choose(0.99,0.995,1,1.1));
	}
	else if (player_lock.object_index == obj_player_dummy)
	{
		//Send inventory update data to the correct player
		var _d = ds_map_create();
		_d[? "cmd"] = "inventory_add_item";
		_d[? "item"] = item_id;
		_d[? "p_id"] = player_lock.p_id;
		send_data(_d);
	}
}