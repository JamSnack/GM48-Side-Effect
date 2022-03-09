/// @description Insert description here
// You can write your code in this editor
mb_left_released = mouse_check_button_released(mb_left);

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

//-- Tile placement

if (currently_placing != false && mb_left_released)
{
	var _mx = floor(mouse_x/32)*32;
	var _my = floor(mouse_y/32)*32;
	
	if ((global.is_host == true && global.multiplayer == true) || global.multiplayer == false)
	{
		var _plr = instance_nearest(_mx, _my, PLAYER_TARGET);
		
		if ( point_distance(_mx, _my, _plr.x, _plr.y) > global.tile_size-2)
		{
			if (structure_deduct_cost(currently_placing) == true)
			{
				instance_create_layer(_mx,_my,"Instances",currently_placing);
			}
		} else obj_control.hud_text_buffer += "\nToo close to a player or structure.\n";
	}
	else if (global.is_host == false)
	{
		if (structure_deduct_cost(currently_placing) == true)
		{
			var _d = ds_map_create();
			_d[? "cmd"] = "request_structure_placement";
			_d[? "structure"] = currently_placing;
			_d[? "p_id"] = global.player_id;
			_d[? "x"] = _mx;
			_d[? "y"] = _my;
			send_data(_d);
		}
	}
	
	currently_placing = false;
}


//- Interaction
upgrade_hovering = noone;

if (interaction_open == true) && currently_placing == false
{
	var dx = device_mouse_x_to_gui(0);
	var dy = device_mouse_y_to_gui(0);
	var _xx = 600;
	var _yy = 6;
	
	//Hovering
	if (menu_panel == 0)
	{
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
		else if (point_in_rectangle(dx,dy,_xx+25,_yy+295,_xx+25+64,_yy+295+64))
		{
			upgrade_hovering = ITEMID.item_silver;
		}
	}
	else if (menu_panel == menu_panel_max && mb_left_released)
	{
		if (point_in_rectangle(dx,dy,_xx+25,_yy+70,_xx+25+64,_yy+70+64))
		{
			currently_placing = obj_core_turret;
		}
		else if (point_in_rectangle(dx,dy,_xx+25,_yy+145,_xx+25+64,_yy+145+64))
		{
			currently_placing = obj_red_turret;
		}
	}
	
	//Arrow shenanigans
	if mb_left_released && (point_in_rectangle(dx,dy, _xx+530,_yy, _xx+530+24,_yy+24))
	{
		if (menu_panel > 0) then menu_panel -= 1;	
	}
	else if mb_left_released && (point_in_rectangle(dx,dy, _xx+560,_yy, _xx+560+24,_yy+24))
	{
		if (menu_panel < menu_panel_max) then menu_panel += 1;	
	}
	
	//Click interaction
	if (upgrade_hovering != noone && mouse_check_button_released(mb_left))
	{
		if (global.inventory[upgrade_hovering] > 0)
		{
			if (global.multiplayer == false || global.is_host == true)
			{
				global.inventory[upgrade_hovering] -= 1; //this happens outside scr_apply_core_upgrade b/c we want clients to be able to call scr_apply... w/o taking resources from the host.
				scr_apply_core_upgrade(upgrade_hovering);
			
			
				//Check for upgrades and level up if yeah!
				scr_update_core();
			} 
			else if (global.multiplayer == true)
			{
				var _d = ds_map_create();
				_d[? "cmd"] = "core_upgrade_request";
				_d[? "upgrade"] = upgrade_hovering;
				_d[? "p_id"] = global.player_id;
				send_data(_d);
			}
		} else upgrade_hovering = noone;
		
		update_inventory();
		obj_player.inventory_action_disable = true;
		obj_player.inventory_action_delay = 30;
	}
}

//Death
if (global.game_over == false && hp <= 0)
{
	global.game_over = true;
	
	obj_control.hud_text_buffer = "GAME OVER";
}

//-SPIN
image_angle += 0.5;