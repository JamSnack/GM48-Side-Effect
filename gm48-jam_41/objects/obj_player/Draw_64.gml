/// @Draw inventory & Hud
// You can write your code in this editor

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

//Draw the inventory
if (inventory_open == true)
{
	draw_set_halign(fa_left);
	draw_sprite_stretched(spr_ui_menu,0,0,2,145+270,500);
	//draw_rectangle(0,2,145+300,500,false);
	
	draw_set_font(fnt_terminal_grotesque);
	draw_set_color(c_white);
	draw_text(15,10,"Inventory");
	draw_text_transformed(2,530,"Weight: "+string(items_held)+"/"+string(weight_tolerance),0.7,0.7,0);
	
	
	if (!surface_exists(inventory_surface))
	{
		inventory_surface = surface_create(300,445);
		surface_set_target(inventory_surface);
		draw_clear_alpha(c_white,0);
	
		var pos_x = 10;
		var pos_y = 30+scroll;
		var drawn = 0;
		var item_scale = 3;

		for (i=0; i<ITEMID.last; i++)
		{
			if (global.inventory[i] > 0)
			{
				draw_sprite_ext(spr_item_drops, i, pos_x + 7, pos_y + 10 + drawn*18*item_scale, item_scale, item_scale, 0, c_white, 1);
				draw_text(pos_x + 44, pos_y + 44 + drawn*18*item_scale, string(global.inventory[i]));
			
				/*
				//Ui hitbox debugging
				var item_x_pos =  pos_x + 7;
				var item_y_pos = pos_y + 10 + drawn*18*item_scale;
				var hbox_x = item_scale*16;
				var hbox_y = item_scale*16;
				draw_rectangle(item_x_pos,item_y_pos, item_x_pos + hbox_x, item_y_pos + hbox_y,false);
				*/
				drawn += 1;
			}
		}
		
		surface_reset_target();
	}

	draw_surface(inventory_surface,0,40);
	
	//-- Draw stats
	var stats_scale = 0.7;
	var _oy = 30;
	
	draw_set_color(c_white);
	
	draw_text_transformed(150,_oy+10,"Max Movement Speed: "+string(max_speed),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+30,"Acceleration: "+string(agility),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+50,"Mining Cooldown: "+string(mining_rate),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+70,"Mining Damage: "+string(mining_damage),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+90,"Mining Range: "+string(mining_range),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+110,"Attack Cooldown: "+string(attack_rate),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+130,"Attack Damage: "+string(attack_damage),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+150,"Max HP: "+string(maxHp),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+170,"HP Regen Cooldown: "+string(hp_regen_rate),stats_scale,stats_scale,0);
	draw_text_transformed(150,_oy+190,"HP Regen Amt: "+string(hp_regen_amt),stats_scale,stats_scale,0);
	
	
	//- Draw tooltip
	if (mining == false)
	{
		if tooltip_data != 0
		{
			draw_set_color(c_black);
			draw_rectangle(mx,my,mx+300,my+120,false);
			
			draw_set_color(c_white)
			
			//Name
			draw_text(mx+8,my+4,tooltip_data[0]);
			
			var text_scale = 0.5;
			//Description
			draw_text_transformed(mx+8,my+46,tooltip_data[1], text_scale, text_scale, 0);
			
			//Positive Effect
			draw_set_color(c_green);
			draw_text_transformed(mx+8,my+60,tooltip_data[2], text_scale, text_scale, 0);
			
			//Negative Effect
			draw_set_color(c_red);
			draw_text_transformed(mx+8,my+74,tooltip_data[3], text_scale, text_scale, 0);
		}
	}
}
else
{
	draw_set_color(c_white);
	draw_text_transformed(2,2,"HP: "+string(hp)+"/"+string(maxHp),0.8,0.8,0);
	draw_text_transformed(2,20,"Weight: "+string(items_held)+"/"+string(weight_tolerance),0.7,0.7,0);
}
	