/// @description Initialize multiplayer stuff
// You can write your code in this editor

//Initialize Multiplayer stuff
global.socket = noone;
global.socketlist = ds_list_create();
global.game_seed = 13371337; //Init the game_seed. TODO: Replace value with a randomize function
global.multiplayer = false; //Whether or not this is a multiplayer game.
global.is_host = false; //Whether or not this client is hosting a multiplayer game.
global.player_id = irandom(99999);
global.player_count = 1;