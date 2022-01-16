/// @description Insert description here
// You can write your code in this editor

//-- Check for movement
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_inventory = keyboard_check_released(ord("F"));

var hmove = (key_right - key_left);
hspd += hmove*( agility * 0.1 * weight);

var vmove = (key_down - key_up);
vspd += vmove*( agility * 0.1 * weight);

//-- Apply friction
var _f = 0.07;

hspd = approach(hspd, 0, _f);
vspd = approach(vspd, 0 ,_f);

//-- Clamp itS
var _ms = max_speed;

if (max_speed <= 0) then _ms = 0.1;


hspd = clamp(hspd, -_ms, _ms);
vspd = clamp(vspd, -_ms, _ms);

//-- Horizontal Collision
if (hspd != 0 && place_meeting_fast(hspd, 0, OBSTA, false))
{
	hspd = -hspd;
}


//-- Vertical Collision
if ( vspd != 0 && place_meeting_fast(0, vspd, OBSTA, false) )
{
	vspd = -vspd;
}

//-- Move the player
//show_debug_message(string(hspd) + " : " + string(vspd) );
x += hspd;
y += vspd;

//-- DESTICK AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
/*if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, OBSTA, false, false))
{
	x -= hspd;
	y -= vspd;
}*/

//-- Rotate sprite
if (hspd != 0 || vspd != 0)
{
	sprite_rotation = point_direction(x,y,x+hspd,y+vspd);
}

//-- keyboard shenanigans
if (key_inventory)
{
	inventory_open = !inventory_open;
	
	//Use expensive function to resynch items_held just in-case!
	items_held = get_inventory_size();
}

//-- Inventory animation

//-- Mining and attack
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

if (mining == false && attack_delay <= 0 && mouse_check_button(mb_right))
{
	var b = instance_create_layer(x,y,"Instances",obj_bullet);
	b.direction = point_direction(x,y,mouse_x,mouse_y);
	b.speed = 12;
	b.damage = attack_damage;
	b.image_angle = b.direction;
	b.objective = ENEMY;
	attack_delay = attack_rate;
}

if mining_delay > 0 then mining_delay -= 1;
if attack_delay > 0 then attack_delay -= 1;

//-- Handle tooltip
if (inventory_open == true) && consume_delay <= 0
{
	var pos_x = 10;
	var pos_y = 30;
	var drawn = 0;
	var item_scale = 3;
	
	var item_x_pos =  pos_x + 7;
	var hbox_x = item_scale*16;
	var hbox_y = item_scale*16;

	for (i=0; i<ITEMID.last; i++)
	{
		var item_y_pos = pos_y + 10 + drawn*18*item_scale;
		
		if (global.inventory[i] > 0)
		{
			drawn += 1;
			
			if (point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),item_x_pos,item_y_pos, item_x_pos + hbox_x, item_y_pos + hbox_y))
			{
				tooltip_data = get_item_data(i);
				
				if (mouse_check_button_released(mb_left))
				{
					global.inventory[i] -= 1;
					consume_material(i);
					consume_delay = 8;
				}
				
				break;
			} else tooltip_data = 0;
		}
	}
}

consume_delay -= 1;

//Encumbered!
if (items_held > weight_tolerance)
{
	if (encumber_prompt = false)
	{
		encumber_prompt = true;
		obj_control.hud_text_buffer += "\nYou are encumbered!\n";	
	}
	
	weight = weight_tolerance/items_held;
	
} 
else
{ encumber_prompt = false; weight = 1; }
