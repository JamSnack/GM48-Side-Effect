// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function update_inventory()
{
	with obj_player
	{
		surface_free(inventory_surface);
		items_held = get_inventory_size();
	}
}