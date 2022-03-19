// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_chat(str)
{
	var _ch = ds_map_create();
	_ch[? "cmd"] = "chat_message";
	_ch[? "message"] = str;
	_ch[? "id"] = global.player_id;
	send_data(_ch);
}

function check_for_existance()
{
	if (global.is_host == false && global.multiplayer == true)
	{
		var _d = ds_map_create();
		_d[? "cmd"] = "existance_bounce";
		_d[? "p_id"] = global.player_id;
		_d[? "o_index"] = object_index;
		_d[? "o_id"] = object_id;
		send_data(_d);
	}
}

function lobby_init_connection()
{
	//Handshake with the host, sending our playername
	var _d = ds_map_create();
	_d[? "cmd"] = "lobby_init_connection";
	_d[? "name"] = global.player_name;
	send_data(_d);
}

function sync_lobby()
{
	if (global.is_host == true)
	{
		//For use by the host.
		var _da = ds_map_create();
		_da[? "cmd"] = "sync_lobby_init_connection";
	
		//Package difficulty
		var _pack = (instance_exists(obj_menu_control)) ? obj_menu_control.selected_difficulty : 2; //<- Normal difficulty
		_da[? "dif"] = _pack;
	
		//Package player_name_list
		_da[? "pl_size"] = ds_list_size(global.player_name_list);
					
		for (var _p = 0; _p < _da[? "pl_size"]; _p++)
		{
			_da[? string(_p)] = global.player_name_list[| _p];
		}
		
		//Package world size
		_da[? "w_size"] = (instance_exists(obj_menu_control)) ? obj_menu_control.new_world_size : 3500; //<- Default world size
					
		send_data(_da);
	}
}

function lobby_search(l_id)
{
	var _ds = ds_map_create();
	_ds[? "cmd"] = "lobby_info";
	_ds[? "id"] = l_id;
	send_data(_ds);
}

function destroy_object(object_index, object_id)
{
	var _da = ds_map_create();
	_da[? "cmd"] = "object_destroy";
	_da[? "object_index"] = object_index;
	_da[? "object_id"] = object_id;
	send_data(_da);
}