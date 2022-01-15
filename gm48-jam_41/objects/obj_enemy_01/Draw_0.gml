/// @description Insert description here
// You can write your code in this editor
draw_self();

if (mining == true)
{
	draw_line(x,y,mining_point_x,mining_point_y);	
}

if (hp < maxHp)
{
	draw_set_color(c_white);
	draw_set_font(fnt_terminal_grotesque);
	draw_set_halign(fa_center);
	draw_text_transformed(x,y+30,string(hp)+"/"+string(maxHp),0.6,0.6,0);
	draw_set_halign(fa_left);
}