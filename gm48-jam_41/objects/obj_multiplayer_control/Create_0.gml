/// @description Initialize multiplayer stuff
// You can write your code in this editor
randomise();

//Initialize Multiplayer stuff
global.socket = noone;
global.socketlist = ds_list_create();
global.game_seed = 13371337; //Init the game_seed. TODO: Replace value with a randomize function
global.multiplayer = false; //Whether or not this is a multiplayer game.
global.is_host = false; //Whether or not this client is hosting a multiplayer game.
global.player_id = irandom(99999);
global.player_count = 1;
global.player_name = choose("Avocado","Crab","Cheeto","Lemon","Birds","Callous","Wool","Baby","Sweet","Tart","Armor")+string(global.player_id);
global.player_name_list = ds_list_create();
global.networking_debug = true; //Whether or not to dislay networking debug stuff

simulate_lag = true;
simulate_lag_ping = 100;
ping = 0;
display_ping = 0;
packet_queue = ds_list_create();

//Garbage packet collection
global.recently_destroyed_objects = ds_list_create();
global.recently_destroyed_tiles = ds_list_create();

function refresh_lobby_names()
{
	if (global.is_host == true)
	{
		//Flush player name list
		ds_list_destroy(global.player_name_list);
		global.player_name_list = ds_list_create();
		ds_list_add(global.player_name_list, global.player_name);
	
		//Ask clients for new information
		var _d = ds_map_create();
		_d[? "cmd"] = "request_lobby_init_connection";
		send_data(_d);
		
		sync_lobby();
	}
}