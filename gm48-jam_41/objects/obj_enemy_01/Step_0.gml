/// @description Insert description here
// You can write your code in this editor
if (instance_exists(objective))
{
	if (distance_to_object(obj_player) > global.tile_size*8)
	{
		objective = obj_core;	
	} else objective = obj_player;
	
    //Direction
    var dir = sign(objective.x-x);
    var vdir = sign(objective.y-(y+16));
        
    //Horizontal Acceleration
    if dir == -1 //Objective is to the right
    { if hAccel > -maxAccel then hAccel -= accelRate; }
    else if dir == 1 { if hAccel < maxAccel then hAccel += accelRate; }
        
    //Vertical Acceleration
    if vdir == -1 //Objective is up
    { if vAccel > -maxAccel then vAccel -= accelRate; }
    else if vdir == 1 { if vAccel < maxAccel then vAccel += accelRate; }
	
	//Collision and movement
	if !place_meeting_fast(hAccel,0,OBSTA, false)
	{ x += hAccel; }
	else
	{
	    hAccel = -hAccel;
	}

	if !place_meeting_fast(0,vAccel,OBSTA, false)
	{ y += vAccel; }
	else
	{
	    vAccel = -vAccel;
	}
	
	
	
	image_angle = point_direction(x,y,x+hAccel,y+vAccel);
	
	//Shoot at objective
	if (shoot_delay <= 0)
	{
		var _tile = !collision_line(x,y,objective.x,objective.y,obj_tile,false,false);
		
		if ( _tile == noone && collision_line(x,y,x+lengthdir_x(global.tile_size*6,image_angle),y+lengthdir_y(global.tile_size*6,image_angle), objective, false, false) != noone)
		{
			//FIRE
			shoot_delay = shoot_delay_set;
			
			
		}
		else
		{
			shoot_delay = mining_delay_set;
			
			with _tile
			{
				drop_item = false;
				instance_destroy();
			}
		}
		
	} else shoot_delay -= 1;
}