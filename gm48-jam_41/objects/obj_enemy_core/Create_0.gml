/// @description Insert description here
// You can write your code in this editor

image_speed = 0;

maxHp = 13;
hp = maxHp;

alarm[0] = room_speed*240; //Level Up
alarm[1] = room_speed; //Spawn Unit
alarm[2] = room_speed*2; //Heal



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