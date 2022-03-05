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