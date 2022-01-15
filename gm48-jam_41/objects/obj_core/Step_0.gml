/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_player))
{
	//Enable interaction
	if (distance_to_object(obj_player) < global.tile_size*2)
	{
		if interaction_text_alpha < 1.0 then interaction_text_alpha += 0.1;
		
		if (keyboard_check_released(ord("E")))
		{
			interaction_open = !interaction_open;	
		}
	}
	else
	{
		if interaction_text_alpha > 0 then interaction_text_alpha -= 0.04;
		interaction_open = false;	
	}
}

image_angle += 0.5;