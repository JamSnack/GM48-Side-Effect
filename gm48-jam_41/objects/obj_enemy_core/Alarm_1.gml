/// @description Insert description here
// You can write your code in this editor
//Spawn a minion
instance_create_layer(x,y,"Instances",obj_enemy_01);

alarm[1] = room_speed*120 + (instance_number(obj_enemy_01)*10);
