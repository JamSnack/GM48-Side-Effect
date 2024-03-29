/// @description Insert description here
// You can write your code in this editor

hspd = 0;
vspd = 0;

//Player stats
max_speed = 4;
agility = 1;
weight_tolerance = 32; //How much weight you can carry before it starts to encumber you.
weight = 1;
attack_rate = room_speed; //How many frames to wait until the next projectile.
attack_damage = 1;
mining_rate = 60; //How many frames to wait until the next mining tick.
mining_damage = 1; //How much damage is dealt to a tile per mining tick.
mining_range = global.tile_size*4;
maxHp = 10;
hp = maxHp;
hp_regen_rate = room_speed*5;
hp_regen_amt = 1;

attack_delay = 0;
respawn_delay = 0;
dead = false;

//Other
mask_index = hbox_player;
sprite_rotation = 0;
multiplayer_delay = 0;

//Inventory
inventory_open = false;
tooltip_data = 0;
items_held = 0;
encumber_prompt = false;
consume_delay = 0;
inventory_surface = surface_create(700,800);
scroll = 0;
inventory_action_disable = false;
inventory_action_delay = 20;

//Tutorial
tutorial_eat = 15;
tutorial_toss = 15;
tutorial_inventory = 3;

//Mining
mining = false;
mining_delay = 0;

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

//X, y
x = round(x);
y = round(y);

draw_set_font(fnt_terminal_grotesque);

//Scuffed core spawn
instance_create_layer(x,y-64,"Instances",obj_core);

//Slow HP regen
alarm[0] = room_speed*5;

//Anim
flame_index = 0;
flame_scale = 1;
flame_xscale = 1;

audio_play_sound(snd_arrival,3,false);

/*
global.inventory[ITEMID.item_aluminum] = 24;
global.inventory[ITEMID.item_ruby] = 10;
global.inventory[ITEMID.item_obsidian] = 10;