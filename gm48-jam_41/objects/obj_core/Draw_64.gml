/// @description Insert description here
// You can write your code in this editor
//Draw interaction menu
if (interaction_open == true)
{
	var _xx = 600;
	var _yy = 6;
	draw_sprite_stretched(spr_ui_menu,0,_xx,_yy,500,600);
	
	//Draw interaction buttons and such
	var item_scale = 4;
	var text_scale = 0.5;
	draw_text(_xx+33,_yy+30,"Deposit resources for upgrades.");
	draw_sprite_ext(spr_item_drops,ITEMID.item_stone,_xx+25,_yy+70,item_scale,item_scale,0,c_white,1);
	draw_text_transformed(_xx+90,_yy+120,"Core HP",text_scale,text_scale,0);
	draw_sprite_ext(spr_item_drops,ITEMID.item_coal,_xx+25,_yy+145,item_scale,item_scale,0,c_white,1);
	draw_text_transformed(_xx+90,_yy+195,"Core Turret Fire-Rate",text_scale,text_scale,0);
	draw_sprite_ext(spr_item_drops,ITEMID.item_iron,_xx+25,_yy+220,item_scale,item_scale,0,c_white,1);
	draw_text_transformed(_xx+90,_yy+270,"Core Turret Damage",text_scale,text_scale,0);
	
	//Draw XP bars
	draw_set_colour(c_black);
	draw_rectangle(_xx+90,_yy+80,_xx+390,_yy+110,false);
	draw_rectangle(_xx+90,_yy+170-15,_xx+390,_yy+170+15,false);
	draw_rectangle(_xx+90,_yy+245-15,_xx+390,_yy+245+15,false);
	
	draw_set_colour(c_purple);
	draw_rectangle(_xx+90,_yy+80,_xx+90+(300*(core_hp_xp/core_hp_xp_max)),_yy+110,false);
	draw_rectangle(_xx+90,_yy+170-15,_xx+90+(300*(core_turret_rate_xp/core_turret_rate_xp_max)),_yy+170+15,false);
	draw_rectangle(_xx+90,_yy+245-15,_xx+90+(300*(core_turret_damage_xp/core_turret_damage_xp_max)),_yy+245+15,false);
	
	//Hitbox debugging
	//draw_rectangle(_xx+25,_yy+145,_xx+25+64,_yy+145+64,false);
}

