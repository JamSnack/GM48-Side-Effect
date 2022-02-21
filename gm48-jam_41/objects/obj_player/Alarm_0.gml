/// @description Insert description here
// You can write your code in this editor

if dead == false && global.game_over == false
{
	if (hp < maxHp) then hp += hp_regen_amt;
	if (hp > maxHp) then hp = maxHp;
}

alarm[0] = hp_regen_rate;

//Send player stats
event_user(1);