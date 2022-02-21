/// @description Draw the guy!
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,c_white,1);

//Draw the flame
draw_sprite_ext(spr_flame, flame_index, x-lengthdir_x(9,image_angle),y-lengthdir_y(8,image_angle),flame_scale,flame_scale*flame_xscale,image_angle,c_white,1);

//Draw HP
if (hp < maxHp)
{
	draw_set_color(c_white);
	draw_set_font(fnt_terminal_grotesque);
	draw_set_halign(fa_center);
	
	if (hp > 0) { draw_text_transformed(x,y+30,string(hp)+"/"+string(maxHp),0.6,0.6,0); }
}