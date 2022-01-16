/// @description Insert description here
// You can write your code in this editor
if (jitter_x != 0)
{
	jitter_x += choose(0.03, -0.02, 0.02, -0.03);
	jitter_x = approach(jitter_x,0,choose(0.1,0.1,0.1,0.1,0.2,0.3));
}

if (jitter_y != 0)
{
	jitter_y += choose(0.03, -0.02, 0.02, -0.03);
	jitter_y = approach(jitter_y,0,choose(0.1,0.1,0.1,0.1,0.2,0.3));
}