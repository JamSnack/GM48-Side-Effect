/// @description Insert description here
// You can write your code in this editor
maxHp = 2;
hp = 1;
attack_rate = obj_core.core_turret_rate;
attack_range = global.tile_size*5;
attack_angle = 0;
attack_delay = 0;
attack_damage = obj_core.core_turret_damage;

//show_debug_message("turret> yolah");

//Poke a hole
while collision_circle(x,y,global.tile_size*2,obj_tile,false,false) != noone
{
	with collision_circle(x,y,global.tile_size*2,obj_tile,false,false)
	{
		drop_item = false;
		update_tile_light(x,y);
		instance_destroy();
	}
}

alarm[0] = room_speed*2;

play_sound_local(snd_alien_charge,x,y);

with (obj_core) event_user(0);