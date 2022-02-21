/// @description Insert description here
// You can write your code in this editor
alarm[0] = room_speed*7;

damage = 1;
objective = noone;

play_sound_local(snd_attack,x,y);

//Spawn dummy bullets in multiplayer games
alarm[1] = 1;