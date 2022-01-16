/// @description Insert description here
// You can write your code in this editor
if (keyboard_key != 0 && begin_sequence == false)
{
	begin_sequence = true;
}

if (begin_sequence = true)
{
	_alpha -= 0.01;
	
	if _alpha <= -0.5 then room_goto(Room1);
}