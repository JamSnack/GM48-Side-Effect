/// @description Guess as to where the ship is flying!
//Movement
x += hspd;
y += vspd;

//Rotation
image_angle = point_direction(x,y,x+hspd,y+vspd);

//Flame animate
flame_scale = min(abs(hspd)+abs(vspd), 2.75);
flame_index += (abs(hspd)+abs(vspd))*0.1;
flame_xscale = choose(1,-1);

//Death stuff
if (hp <= 0) { visible = false; }
	else visible = true;