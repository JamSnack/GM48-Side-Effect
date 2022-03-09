/// @description Insert description here
// You can write your code in this editor

if (place_meeting_fast(hspeed,vspeed,obj_tile,false)) { instance_destroy(); }
else if (instance_exists(objective) && place_meeting_fast(hspeed,vspeed,objective,false))
{	
	if ((global.multiplayer == true && global.is_host == true) || global.multiplayer == false)
	{
		hurt_instance(objective, damage);
	}
	
	instance_destroy();
}