// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function play_sound_local(sound_id)
{
	var _r = global.tile_size*26;
	
	if (point_distance(camera.x,camera.y,x,y) <= _r)
	{
		audio_play_sound_at(sound_id,x,y,0,global.tile_size*6,_r,1,false,2);
	}
}