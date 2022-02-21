/// @description Insert description here
// You can write your code in this editor
global.game_paused = !global.game_paused;


//Physically pause instances
if (global.multiplayer == true) then exit;
if (global.game_paused == true)
{
	with (PAUSE)
	{
		var _z = instance_create_layer(x,y,"Instances",obj_paused_object);
		
		_z.sprite_index = sprite_index;
		_z.image_index = image_index;
		_z.image_angle = image_angle;
		_z.image_alpha = image_alpha;
		_z.image_xscale = image_xscale;
		_z.image_yscale = image_yscale;
		_z.image_speed = 0;
		
		//Fix tiles
		if (object_index == obj_tile)
		{
			_z.light = light;	
		}
	}
	
	instance_deactivate_object(PAUSE);
}
else
{
	with (obj_paused_object) { instance_destroy(); }
	
	instance_activate_object(PAUSE);
}