// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function difficulty_to_string(difficulty)
{
	switch (difficulty)
	{
		case 0: { return "Peaceful"; } break;
		case 1: { return "Easy"; } break;
		case 2: { return "Normal"; } break;
		case 3: { return "Hard"; } break;
		case 4: { return "Extreme"; } break;
		default: { return "Null"; } break;
	}
}