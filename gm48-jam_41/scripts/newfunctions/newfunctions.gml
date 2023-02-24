function create_item(item_id, x, y)
{
	if (global.is_host)
	{
		var _i = instance_create_layer(x, y, "Instances", obj_item);
	
		_i.item_id = item_id;
		_i.image_index = item_id;
		_i.pickup_delay = room_speed*1;
		_i.speed = 12;
		_i.direction = irandom(360);
	}
}

//--- World Gen Functions ---
function generate_worm(repeat_amt,tile_placing,life_span,radius,is_ore)
{
	repeat(repeat_amt)
	{
		var ore_worm = instance_create_layer(irandom_range(0,game_world_width),irandom_range(0,game_world_height),"Instances",obj_generator_worm);
		ore_worm.tile_placing = tile_placing;
		ore_worm.life_span = life_span;
		ore_worm.radius = radius;
		ore_worm.is_ore = is_ore;
		ore_worm.room_h = game_world_height;
		ore_worm.room_w = game_world_width;
	}
}
			
function scale_distribution(base_rate)
{
	//Base_rate is how many worms we want to spawn in a normal (110x110) world.
	show_debug_message("scrate: " + string((ceil(game_world_width/global.tile_size) > 110)));
	if (ceil(game_world_width/global.tile_size) > 110)
	{
		return base_rate + floor(ceil(game_world_width/global.tile_size)/42);
	}
	else return base_rate;
}