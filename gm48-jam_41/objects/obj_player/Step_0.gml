/// @description Insert description here
// You can write your code in this editor

//-- Check for movement
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_inventory = keyboard_check_released(ord("F"));

var hmove = (key_right - key_left);
hspd += hmove*( agility * 0.1);

var vmove = (key_down - key_up);
vspd += vmove*( agility * 0.1);

hspd = clamp(hspd, -max_speed, max_speed);
vspd = clamp(vspd, -max_speed, max_speed);

//-- Horizontal Collision
if ( place_meeting_fast(hspd, 0, OBSTA, false) )
{
	var _d = sign(hspd);
	
	repeat(25) 
	{
		if ( !place_meeting_fast(_d, 0, OBSTA, false) )
		{
			x += _d;
		} else break;
	}
	
	hspd = 0;
}


//-- Vertical Collision
if ( place_meeting_fast(0, vspd, OBSTA, false) )
{
	var _d = sign(vspd);
	
	repeat(25) 
	{
		if ( !place_meeting_fast(0, _d, OBSTA, false) )
		{
			y += _d;
		} else break;
	}
	
	vspd = 0;
}

//-- Move the player
//show_debug_message(string(hspd) + " : " + string(vspd) );
x += hspd;
y += vspd;

//-- Rotate sprite
if (hspd != 0 || vspd != 0)
{
	sprite_rotation = point_direction(x,y,x+hspd,y+vspd);
}


//-- Apply friction
var _f = 0.07;

hspd = approach(hspd, 0, _f);
vspd = approach(vspd, 0 ,_f);

//-- keyboard shenanigans
if (key_inventory)
{
	inventory_open = !inventory_open;
}

//-- Inventory animation

//-- Mining
if (mining_delay <= 0 && mouse_check_button(mb_left) && distance_to_point(mouse_x,mouse_y) <= mining_range)
{
	var _mine = collision_circle(mouse_x,mouse_y,2,obj_tile,false,false);
	
	if _mine != noone
	{
		var _dam = mining_damage;
		
		with _mine
		{
			hp -= _dam;
			
			if (hp <= 0)
			{
				instance_destroy();	
			}
		}
		
		mining = true;
		mining_delay = mining_rate;
		
	} else mining = false;
	
} else mining = false;

if mining_delay > 0 then mining_delay -= 1;
