/// @description Insert description here
// You can write your code in this editor

hspd = 0;
vspd = 0;

//Player stats
max_speed = 16;
agility = 2;
weight_tolerance = 5;
attack_rate = room_speed*2; //How many frames to wait until the next projectile.
attack_damage = 1;
mining_rate = 0; //How many frames to wait until the next mining tick.
mining_damage = 5; //How much damage is dealt to a tile per mining tick.
mining_range = global.tile_size*4;
maxHp = 10;
hp = maxHp;

//Other
mask_index = hbox_player;
sprite_rotation = 0;

//Inventory
inventory_open = false;

//Mining
mining = false;
mining_delay = 0;