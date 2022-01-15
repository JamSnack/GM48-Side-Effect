// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function update_tile_light(xx,yy){
	
	var _list = ds_list_create();
	var amount = collision_rectangle_list(xx-17,yy-17,xx+17,yy+17,obj_tile,false,true,_list,false);
	
	for (_i = 0; _i < amount; _i++)
	{
		with ds_list_find_value(_list, _i)
		{
			light = 1;	
		}
	}
}