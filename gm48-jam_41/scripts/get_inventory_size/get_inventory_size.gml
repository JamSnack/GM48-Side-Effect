// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_inventory_size()
{
	var _a = 0;
	
	for(_k = 0; _k < array_length(global.inventory); _k++)
	{
		_a += global.inventory[_k];
	}
	
	return _a;
}