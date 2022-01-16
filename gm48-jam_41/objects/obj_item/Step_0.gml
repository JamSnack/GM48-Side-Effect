/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_player) && pickup_delay <= 0)
{
	var distance_to_player = distance_to_object(obj_player);
	
	if (distance_to_player < global.tile_size*2)
	{
		motion_add(point_direction(x,y,obj_player.x,obj_player.y),1);
	
		image_angle += hspeed;
	
		if (distance_to_player < 2)
		{
			global.inventory[item_id] += 1;
			
			update_inventory();
			instance_destroy();
			_sn = audio_play_sound(snd_true_blip,1,false);
			audio_sound_pitch(_sn,choose(0.99,0.995,1,1.1));
		}
	}
}
else if (pickup_delay > 0)
{
	pickup_delay -= 1;
	
	//Collision
	if (speed != 0)
	{
		image_angle += ((hspeed)+(vspeed))*2;
	
		if (place_meeting_fast(hspeed,0,OBSTA,false)) { hspeed = 0; };
		if (place_meeting_fast(0,vspeed,OBSTA,false)) { vspeed = 0; };
	}
}