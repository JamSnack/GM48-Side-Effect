/// @description Insert description here
// You can write your code in this editor
//Draw the player
//draw_sprite_ext(mask_index,image_index,x,y,1,1,image_angle,c_white,1);

if (dead == false && global.game_over == false)
{
	draw_sprite_ext(sprite_index,image_index,x,y,1,1,sprite_rotation,c_white,1);

	//Draw the flame
	draw_sprite_ext(spr_flame, flame_index, x-lengthdir_x(9,sprite_rotation),y-lengthdir_y(8,sprite_rotation),flame_scale,flame_scale*flame_xscale,sprite_rotation,c_white,1);
}

//Draw the mining laser
if mining == true
{
	draw_line(x,y,mouse_x,mouse_y);
}

//Draw hp underneath ya!
if (hp < maxHp)
{
	draw_set_color(c_white);
	draw_set_font(fnt_terminal_grotesque);
	draw_set_halign(fa_center);
	
	if (hp > 0) { draw_text_transformed(x,y+30,string(hp)+"/"+string(maxHp),0.6,0.6,0); }
	else
	{
		draw_text_transformed(x,y+20,"You Died!\nRespawning in... "+string(floor(respawn_delay/60)),0.6,0.6,0);
	}
	
	draw_set_halign(fa_left);
}