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

function init_connection()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "init_connection";
	_d[? "name"] = global.player_name;
	send_data(_d);
}

function sync_lobby()
{
	//For use by the host.
	var _da = ds_map_create();
	_da[? "cmd"] = "sync_init_connection";
	_da[? "size"] = ds_list_size(global.player_name_list);
					
	for (var _p = 0; _p < _da[? "size"]; _p++)
	{
		_da[? string(_p)] = global.player_name_list[| _p];
	}
					
	send_data(_da);
}