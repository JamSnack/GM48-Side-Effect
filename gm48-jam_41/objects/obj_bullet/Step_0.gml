/// @description Insert description here
// You can write your code in this editor
if (place_meeting_fast(hspeed,vspeed,obj_tile,false)) then instance_destroy();
else if ( instance_exists(objective) && place_meeting_fast(hspeed,vspeed,objective,false))
{
	var _d = damage;
	
	with instance_nearest(x,y,objective)
	{
		hp -= _d;
	}
	
	instance_destroy();
}