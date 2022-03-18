/// @description Insert description here
// You can write your code in this editor

if dead == false && global.game_over == false
{

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
	if (abs(hspd) >= 1 && place_meeting_fast(hspd, 0, OBSTA, false))
	{
		hspd = -hspd;
	} if (place_meeting_fast( sign(hspd), 0, OBSTA, false)) { hspd = 0; }


	//-- Vertical Collision
	if ( abs(vspd) >= 1 && place_meeting_fast(0, vspd, OBSTA, false) )
	{
		vspd = -vspd;
	}
	else if (place_meeting_fast(0, sign(vspd), OBSTA, false)) { vspd = 0; }

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
		
		if (tutorial_inventory > 0) then tutorial_inventory -= 1;
	
		//Use expensive function to resynch items_held just in-case!
		update_inventory();
		
		//scroll
		scroll = 0;
	}

	//-- Inventory animation

	//-- Mining and attack
	if (inventory_action_disable == false && mining_delay <= 0 && mouse_check_button(mb_left) && distance_to_point(mouse_x,mouse_y) <= mining_range)
	{
		var _mine = collision_circle(mouse_x,mouse_y,2,obj_tile,false,false);
	
		if _mine != noone
		{
			var _dam = mining_damage;
		
			with _mine
			{
				hp -= _dam;
				jitter_x = choose(2,-2,-1,1);
				jitter_y = choose(2,-2,-1,1);
				depth = -2; //Sneakily enhancing the jitter effect...
			
				if (hp <= 0)
				{
					instance_destroy();	
				}
			}
		
			mining = true;
			mining_delay = mining_rate;
			audio_play_sound(snd_zaply,1,false);
		
		} else mining = false;
	
	} else mining = false;

	if (inventory_action_disable == false && mining == false && attack_delay <= 0 && mouse_check_button(mb_right))
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
}


//-- Handle tooltip
if (inventory_open == true) && consume_delay <= 0
{
	var pos_x = 10;
	var pos_y = 30+scroll+40; //scroll+surface
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
					update_inventory();
					
					if (tutorial_eat > 0) then tutorial_eat -= 1;
				}
				else if (mouse_check_button_released(mb_right))
				{
					global.inventory[i] -= 1;
					var _z = instance_create_layer(x,y,"Instances",obj_item);
					_z.pickup_delay = room_speed;
					_z.speed = 8;
					_z.friction = 0.2;
					_z.direction = sprite_rotation;
					_z.item_id = i;
					_z.image_index = i;
					consume_delay = 10;
					update_inventory();
					
					if (tutorial_toss > 0) then tutorial_toss -= 1;
				}
				
				inventory_action_disable = true;
				inventory_action_delay = 30;
				
				break;
			} else { tooltip_data = 0; }
		}
	}
	
	//surface_free(inventory_surface);
}
else
{
	tooltip_data = 0;
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


//World border
if (instance_exists(obj_control))
{
	x = clamp(x,0,obj_control.game_world_width);
	y = clamp(y,0,obj_control.game_world_height);
}

//Death
if (hp <= 0 && respawn_delay <= 0 && dead == false)
{
	
	//Drop inventory on death
	for (var _i = 0; _i < ITEMID.last; _i++)
	{
		while ( global.inventory[_i] > 0 )
		{
			global.inventory[_i] -= 1;
			
			var _di = instance_create_layer(x,y,"Instances",obj_item); //death item
			_di.pickup_delay = room_speed;
			_di.speed = 8;
			_di.friction = 0.2;
			_di.direction = irandom(360);
			_di.item_id = _i;
			_di.image_index = _i;
			
			show_debug_message(string(_i));
		}
	}
	
	
	dead = true;
	respawn_delay = 10*room_speed;
	hspd = 0;
	vspd = 0;
	x = obj_core.x;
	y = obj_core.y;
	
	if (global.multiplayer == true)
	{
		send_chat(string(global.player_name) + " has died.");
		event_user(1);
	}

	update_inventory();
	
}
else if (dead == true && respawn_delay <= 0)
{
	hp = maxHp;
	dead = false;
}

if respawn_delay > 0 then respawn_delay -= 1;


//Audio positioning!
audio_listener_set_position(0,x,y,0);

if (!audio_exists(burning_fuel) || !audio_is_playing(burning_fuel))
{
	snd_burning_fuel = audio_play_sound(burning_fuel,1,true);
}
else
{
	audio_sound_gain(snd_burning_fuel,max((abs(hspd+vspd)/(max_speed*2)),0),50)
}

//Flame animate
flame_scale = min(abs(hspd)+abs(vspd), 2.75);
flame_index += (abs(hspd)+abs(vspd))*0.1;
flame_xscale = choose(1,-1);

//Inventory action delay
if (inventory_action_disable == false && inventory_action_delay <= 0)
	inventory_action_delay = 30;
else if (inventory_action_delay > 0)
{
	inventory_action_delay -= 1;
		
	if (inventory_action_delay <= 0)
	{
		inventory_action_disable = false;	
	}
}


//Send multiplayer information
if ((x != xprevious || y != yprevious) && (multiplayer_delay <= 35)) || multiplayer_delay <= 0
{
	multiplayer_delay = 40;
	event_user(0);
}
else if (multiplayer_delay > 0)
{
	multiplayer_delay -= 1;	
}