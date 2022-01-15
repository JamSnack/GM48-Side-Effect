/// @Draw inventory & Hud
// You can write your code in this editor
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

//Draw the inventory
if (inventory_open == true)
{
	draw_set_color(c_gray);
	draw_rectangle(0,2,145,500,false);
	
	draw_set_font(fnt_terminal_grotesque);
	draw_set_color(c_white);
	draw_text(5,5,"Inventory");
	
	
	var pos_x = 10;
	var pos_y = 30;
	var drawn = 0;
	var item_scale = 3;

	for (i=0; i<ITEMID.last; i++)
	{
		if (global.inventory[i] > 0)
		{
			draw_sprite_ext(spr_item_drops, i, pos_x + 7, pos_y + 10 + drawn*18*item_scale, item_scale, item_scale, 0, c_white, 1);
			draw_text(pos_x + 44, pos_y + 44 + drawn*18*item_scale, string(global.inventory[i]));
			drawn += 1;
		}
	}
	
	//- Draw tooltip
	if (mining == false)
	{
		if tooltip_data != 0
		{
			draw_set_color(c_black);
			draw_rectangle(mx,my,mx+140,my+120,false);
			
			draw_set_color(c_white)
			
			//Name
			draw_text(mx+8,my+4,tooltip_data[0]);
			
			var text_scale = 0.5;
			//Description
			draw_text_transformed(mx+8,my+35,tooltip_data[1], text_scale, text_scale, 0);
			
			//Positive Effect
			draw_set_color(c_green);
			draw_text_transformed(mx+8,my+45,tooltip_data[2], text_scale, text_scale, 0);
			
			//Negative Effect
			draw_set_color(c_red);
			draw_text_transformed(mx+8,my+55,tooltip_data[3], text_scale, text_scale, 0);
		}
	}
	
}




//World border
x = clamp(x,0,room_width);
y = clamp(y,0,room_height);