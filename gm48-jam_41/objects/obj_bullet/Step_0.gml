/// @description Insert description here
// You can write your code in this editor

if (place_meeting_fast(hspeed,vspeed,obj_tile,false)) { instance_destroy(); }
else if (instance_exists(objective) && place_meeting_fast(hspeed,vspeed,objective,false))
{	
	if ((global.multiplayer == true && global.is_host == true) || global.multiplayer == false)
	{
		var _inst = instance_nearest(x,y,objective);
		hurt_instance(_inst, damage);
	}
	
	instance_destroy();
}