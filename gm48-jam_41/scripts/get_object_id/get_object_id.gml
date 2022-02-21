// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_object_id()
{
	if (instance_exists(obj_control))
	{
		obj_control.id_counter++;
		return obj_control.id_counter;
	}
}