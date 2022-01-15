/// @description Insert description here
// You can write your code in this editor
//Draw the player
draw_sprite_ext(sprite_index,image_index,x,y,1,1,sprite_rotation,c_white,1);

//Draw the mining laser
if mining == true
{
	draw_line(x,y,mouse_x,mouse_y);	
}