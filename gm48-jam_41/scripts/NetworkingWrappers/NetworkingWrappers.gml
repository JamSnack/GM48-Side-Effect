// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_chat(str)
{
	var _ch = ds_map_create();
	_ch[? "cmd"] = "chat_message";
	_ch[? "message"] = str;
	send_data(_ch);
}