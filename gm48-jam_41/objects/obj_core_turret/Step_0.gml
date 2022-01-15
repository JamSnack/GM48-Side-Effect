/// @description Insert description here
// You can write your code in this editor
if (attack_delay <= 0 && instance_exists(ENEMY))
{
	var _him = instance_nearest(x,y,ENEMY);
	
	if (distance_to_object(_him) <= attack_range)
	{
		attack_angle = point_direction(x,y,_him.x,_him.y);
		
		var _b = instance_create_layer(x,y,"Instances",obj_bullet);
		_b.damage = attack_damage;
		_b.direction = attack_angle;
		_b.speed = 12;
		_b.objective = _him;
		
		attack_delay = attack_rate;
	}
}
else
{
	attack_angle += 1;
	if attack_delay > 0 then attack_delay -= 1;
}