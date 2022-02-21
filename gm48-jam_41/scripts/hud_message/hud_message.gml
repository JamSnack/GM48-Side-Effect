// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function hud_message(str)
{
	if (instance_exists(obj_control))
		obj_control.hud_text_buffer += "\n"+str;
}