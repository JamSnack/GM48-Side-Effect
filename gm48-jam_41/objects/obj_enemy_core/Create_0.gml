/// @description Insert description here
// You can write your code in this editor

image_speed = 0;

maxHp = 25;
hp = maxHp;

alarm[0] = room_speed*120; //Level Up
alarm[1] = room_speed; //Spawn Unit



//Poke a hole
while collision_circle(x,y,global.tile_size*4,obj_tile,false,false) != noone
{
	with collision_circle(x,y,global.tile_size*4,obj_tile,false,false)
	{
		drop_item = false;
		update_tile_light(x,y);
		instance_destroy();
	}
}