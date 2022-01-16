/// @description Insert description here
// You can write your code in this editor
//Draw interaction menu
if (interaction_open == true && currently_placing == false)
{
	var _xx = 600;
	var _yy = 6;
	draw_sprite_stretched(spr_ui_menu,0,_xx,_yy,500,600);
	
	switch menu_panel
	{
		case 0:
		{
	
			//Draw interaction buttons and such
			//MN: +24 b/c sprite got centered later in development. (sprite_width*item_scale)/2
			
			var item_scale = 4;
			var text_scale = 0.5;
			draw_text(_xx+33,_yy+30,"Deposit resources for upgrades.");
			draw_sprite_ext(spr_item_drops,ITEMID.item_stone,_xx+25+24,_yy+70+24,item_scale,item_scale,0,c_white,1);
			draw_text_transformed(_xx+90,_yy+120,"Core HP    " + string(core_hp_xp) + "/"+string(core_hp_xp_max),text_scale,text_scale,0);
			draw_sprite_ext(spr_item_drops,ITEMID.item_coal,_xx+25+24,_yy+145+24,item_scale,item_scale,0,c_white,1);
			draw_text_transformed(_xx+90,_yy+195,"Core Turret Fire-Rate    " + string(core_turret_rate_xp) + "/"+string(core_turret_rate_xp_max),text_scale,text_scale,0);
			draw_sprite_ext(spr_item_drops,ITEMID.item_iron,_xx+25+24,_yy+220+24,item_scale,item_scale,0,c_white,1);
			draw_text_transformed(_xx+90,_yy+270,"Core Turret Damage    " + string(core_turret_damage_xp) + "/"+string(core_turret_damage_xp_max),text_scale,text_scale,0);
			draw_sprite_ext(spr_item_drops,ITEMID.item_silver,_xx+25+24,_yy+295+24,item_scale,item_scale,0,c_white,1);
			draw_text_transformed(_xx+90,_yy+345,"Core Turret HP    " + string(core_turret_hp_xp) + "/"+string(core_turret_hp_xp_max),text_scale,text_scale,0);
	
			//Draw XP bars
			draw_set_colour(c_black);
			draw_rectangle(_xx+90,_yy+80,_xx+390,_yy+110,false);
			draw_rectangle(_xx+90,_yy+170-15,_xx+390,_yy+170+15,false);
			draw_rectangle(_xx+90,_yy+245-15,_xx+390,_yy+245+15,false);
			draw_rectangle(_xx+90,_yy+320-15,_xx+390,_yy+320+15,false);
	
			draw_set_colour(c_purple);
			draw_rectangle(_xx+90,_yy+80,_xx+90+(300*(core_hp_xp/core_hp_xp_max)),_yy+110,false);
			draw_rectangle(_xx+90,_yy+170-15,_xx+90+(300*(core_turret_rate_xp/core_turret_rate_xp_max)),_yy+170+15,false);
			draw_rectangle(_xx+90,_yy+245-15,_xx+90+(300*(core_turret_damage_xp/core_turret_damage_xp_max)),_yy+245+15,false);
			draw_rectangle(_xx+90,_yy+320-15,_xx+90+(300*(core_turret_hp_xp/core_turret_hp_xp_max)),_yy+320+15,false);
		}
		break;
		
		case menu_panel_max:
		{
			//Turrets n' shot
			var item_scale = 4;
			var text_scale = 0.7;
			
			draw_text(_xx+33,_yy+30,"Deposit resources for defenses.");
			draw_sprite_ext(spr_core_turret,0,_xx+25+(18*item_scale/2),_yy+70+(18*item_scale/2),item_scale,item_scale,0,c_white,1);
			draw_text_transformed(_xx+95,_yy+120,"Turret: Iron x3; Copper x3; Stone x12;",text_scale,text_scale,0);
			draw_sprite_ext(spr_core_turret_red,0,_xx+25+(18*item_scale/2),_yy+145+(18*item_scale/2),item_scale,item_scale,0,c_white,1);
			draw_text_transformed(_xx+95,_yy+195,"Red Turret: Gallium x4; Ruby x3; Obsidian x2;",text_scale,text_scale,0);
		}
		break;
	}
	
	//Draw menu_scrolling arrows	
	draw_set_colour(c_white);
	draw_sprite(spr_ui_arrow,1,_xx+530,_yy);
	draw_sprite(spr_ui_arrow,0,_xx+560,_yy);
	draw_text(_xx+530,_yy+40,"Page: "+string(menu_panel+1)+"/"+string(menu_panel_max+1));
	
	//Hitbox debugging
	//draw_rectangle(_xx+25,_yy+145,_xx+25+64,_yy+145+64,false);
}

