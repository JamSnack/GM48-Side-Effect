// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function play_sound_local(sound_id,xx,yy)
{
	var _r = global.tile_size*26;
	
	if (instance_exists(camera))
	{
		if (point_distance(camera.x,camera.y,xx,yy) <= _r)
		{
			audio_play_sound_at(sound_id,xx,yy,0,global.tile_size*6,_r,1,false,2);
		}
	}
}