// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function place_meeting_fast(x_offset, y_offset, object, notme)
{
	if (collision_rectangle(bbox_left+x_offset,bbox_top+y_offset,bbox_right+x_offset,bbox_bottom+y_offset,object,false,notme) != noone)
	{
		return true;
	}
	else return false;
}