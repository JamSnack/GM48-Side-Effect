/// @description Insert description here
// You can write your code in this editor
depth = -1;

maxAccel = 5;
hAccel = 0;
vAccel = 0;
accelRate = 0.1;

objective = obj_core;
shoot_delay = 0;
shoot_delay_set = 40;
mining_delay_set = room_speed*2;
mining = false;

maxHp = 5;
hp = maxHp;

//multiplayer stuff
object_id = get_object_id();