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
global.networking_debug = true; //Whether or not to dislay networking debug stuff

simulate_lag = true;
simulate_lag_ping = 100;
ping = 0;
display_ping = 0;
packet_queue = ds_list_create();