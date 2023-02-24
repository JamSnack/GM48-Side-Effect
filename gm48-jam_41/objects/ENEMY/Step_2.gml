/// @description Insert description here
// You can write your code in this editor

if (global.is_host == false)
{
	draw_x = lerp(draw_x, x, interpolation_rate);
	draw_y = lerp(draw_y, y, interpolation_rate);

	if (point_distance(draw_x, draw_y, x, y) < 1)
	{
		draw_x = x;
		draw_y = y;
	}
}
else
{
	draw_x = x;
	draw_y = y;
}