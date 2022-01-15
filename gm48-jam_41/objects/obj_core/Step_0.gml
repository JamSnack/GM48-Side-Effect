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


//- Interaction
upgrade_hovering = noone;

if (interaction_open == true)
{
	var dx = device_mouse_x_to_gui(0);
	var dy = device_mouse_y_to_gui(0);
	var _xx = 600;
	var _yy = 6;
	
	//Hovering
	if (point_in_rectangle(dx,dy,_xx+25,_yy+70,_xx+25+64,_yy+70+64))
	{
		upgrade_hovering = ITEMID.item_stone;
	}
	else if (point_in_rectangle(dx,dy,_xx+25,_yy+145,_xx+25+64,_yy+145+64))
	{
		upgrade_hovering = ITEMID.item_coal;
	}
	else if (point_in_rectangle(dx,dy,_xx+25,_yy+220,_xx+25+64,_yy+220+64))
	{
		upgrade_hovering = ITEMID.item_iron;
	}
	
	//Click interaction
	if (upgrade_hovering != noone && mouse_check_button_released(mb_left))
	{
		if (global.inventory[upgrade_hovering] > 0)
		{
			global.inventory[upgrade_hovering] -= 1;
			
			switch upgrade_hovering
			{
				case ITEMID.item_stone: { core_hp_xp += 1;} break;
				case ITEMID.item_coal: { core_turret_rate_xp += 1;} break;
				case ITEMID.item_iron: { core_turret_damage_xp += 1;} break;
			}
			
			
			//Check for upgrades
			if (core_hp_xp >= core_hp_xp_max)
			{
				core_hp_xp_max *= 2;
				core_hp_xp = 0;
				
				maxHp += 25;
				hp = maxHp;
			}
			else if (core_turret_rate_xp >= core_turret_rate_xp_max)
			{
				core_turret_rate_xp_max *= 2;
				core_turret_rate_xp = 0;
				
				core_turret_rate -= 10;
			}
			else if (core_turret_damage_xp >= core_turret_damage_xp_max)
			{
				core_turret_damage_xp_max *= 2;
				core_turret_damage_xp = 0;
				
				core_turret_damage += 1;
			}
			
		} else upgrade_hovering = noone; 
	}
}

//-SPIN
image_angle += 0.5;