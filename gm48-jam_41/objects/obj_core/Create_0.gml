/// @description Insert description here
// You can write your code in this editor

image_speed = 0;

maxHp = 25;
hp = maxHp - 10;

//Text
interaction_text_alpha = 0;
interaction_text = "Press 'E' to interact.";
interaction_open = false;
upgrade_hovering = noone;

//Core stats
core_hp_xp = 0;
core_hp_xp_max = 25;
core_turret_rate_xp = 0;
core_turret_rate_xp_max = 25;
core_turret_damage_xp = 0;
core_turret_damage_xp_max = 25;

core_turret_rate = room_speed*2;
core_turret_damage = 1;

//Healing
alarm[0] = 1;