/// @description Insert description here
// You can write your code in this editor

image_speed = 0;

maxHp = 25;
hp = maxHp - 5;

//Drawing
interaction_text_alpha = 0;
interaction_text = "Press 'E' to interact.";
interaction_open = false;
upgrade_hovering = noone;
menu_panel = 0;
menu_panel_max = 1;
currently_placing = false;

//Core tech
core_hp_xp = 0;
core_hp_xp_max = 25;
core_turret_rate_xp = 0;
core_turret_rate_xp_max = 35;
core_turret_damage_xp = 0;
core_turret_damage_xp_max = 25;
core_turret_hp_xp = 0;
core_turret_hp_xp_max = 30;

core_turret_rate = room_speed;
core_turret_damage = 1;
core_turret_hp = 10;

deposit_timer = 60; //How long to wait until we can deposit another resource.
consecutive_deposits = 0;


//Healing
alarm[0] = 1;

//Message
alarm[1] = room_speed*8;
alarm[2] = room_speed*11;

object_id = get_object_id();