/// @description Insert description here
// You can write your code in this editor
if (light == 1)
{
	draw_sprite_ext(sprite_index,item_id,x+jitter_x,y+jitter_y,abs(jitter_x/2)+1,abs(jitter_y/2)+1,0,c_white,1);	
}
else if (light == 0)
{
	draw_sprite(spr_obsta,0,x,y,);	
}