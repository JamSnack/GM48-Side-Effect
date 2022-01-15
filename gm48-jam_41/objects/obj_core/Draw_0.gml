/// @description Insert description here
// You can write your code in this editor
draw_self();

if (hp < maxHp)
{
	draw_set_color(c_white);
	draw_set_font(fnt_terminal_grotesque);
	draw_set_halign(fa_center);
	draw_text_transformed(x,y+30,string(hp)+"/"+string(maxHp),0.6,0.6,0);
}

if (interaction_open == false)
{
	draw_set_halign(fa_center);
	draw_text_transformed_colour(x,y-64,interaction_text,0.8,0.8,0,c_white,c_white,c_white,c_white,interaction_text_alpha);
}

draw_set_halign(fa_left);