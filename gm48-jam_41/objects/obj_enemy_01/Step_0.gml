/// @description Insert description here
// You can write your code in this editor
if (instance_exists(objective))
{
	var near_play = instance_nearest(x,y,PLAYER);
	
	if (distance_to_object(near_play) > global.tile_size*8)
	{
		objective = obj_core;	
	} else objective = near_play;
}
else objective = obj_core;

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
	var obj_direction = point_direction(x,y,objective.x,objective.y);
		
	if ( !collision_line(x,y,objective.x,objective.y,obj_tile,false,false) )
	{
		//FIRE
		shoot_delay = shoot_delay_set;
			
		var b = instance_create_layer(x,y,"Instances",obj_bullet);
		b.direction = obj_direction;
		b.speed = 10;
		b.damage = 1; //Replace with difficulty;
		b.objective = PLAYER;
		b.image_angle = image_angle;
			
	}
	else
	{
		if instance_exists(obj_tile)
		{
			var _inst = instance_nearest(x+hAccel,y+vAccel,obj_tile);
				
			if distance_to_object(_inst) < global.tile_size*2
			{
				shoot_delay = mining_delay_set;
				mining = true;
				mining_point_x = _inst.x;
				mining_point_y = _inst.y;
				play_sound_local(snd_zaply,x,y);
					
				with _inst
				{
					drop_item = false;
					update_tile_light(x,y);
					instance_destroy();
				}
			}
		}
	}
		
} 
else 
{
	shoot_delay -= 1;
	mining = false;
}


//Death
if (hp <= 0) then instance_destroy();