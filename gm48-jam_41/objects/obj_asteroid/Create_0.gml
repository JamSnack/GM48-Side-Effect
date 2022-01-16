/// @description Insert description here
// You can write your code in this editor
rotation = choose(1,-1);
direction = point_direction(x,y,obj_core.x,obj_core.y);
direction += irandom_range(-45,45);
speed = choose(1,2,3,4);

image_speed = 0;

scale = choose(1,2,3);
image_xscale = scale;
image_yscale = scale;

hp = 1+scale;