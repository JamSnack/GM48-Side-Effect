// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro MB_HOVERING 1
#macro MB_HELD 2
#macro MB_RELEASED 3

function ui_button_check_gui(button_sprite, xscale, yscale, pos_x, pos_y, button_to_check)
{
	var _dx = device_mouse_x_to_gui(0);
	var _dy = device_mouse_y_to_gui(0);
	var _w = sprite_get_width(button_sprite)*xscale;
	var _h = sprite_get_height(button_sprite)*yscale;
	var x_offset = sprite_get_xoffset(button_sprite);
	var y_offset = sprite_get_yoffset(button_sprite);
	
	pos_x = (pos_x-x_offset);
	pos_y = (pos_y-y_offset);
	
	if (point_in_rectangle(_dx, _dy, pos_x, pos_y, pos_x + _w, pos_y + _h))
	{
		if (mouse_check_button(button_to_check)) //Button is being held
		{
			return MB_HELD;
		}
		else if (mouse_check_button_released(button_to_check)) //releasema
		{
			return MB_RELEASED;	
		}
		else return MB_HOVERING;
	} else return false;
}