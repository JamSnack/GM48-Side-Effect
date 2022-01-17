/// @description Insert description here
// You can write your code in this editor

//Play neat sound
audio_play_sound(snd_upgrade_complete,3,false);

//Textuals
obj_control.hud_text_buffer += "\nUpgrade Complete!\n";

//Install new turret hardware
var _hp = core_turret_hp;
var _rate = core_turret_rate;
var _dam = core_turret_damage;

with obj_core_turret
{
	maxHp = _hp;
	attack_rate = _rate;
	attack_damage = _dam;
}

with obj_red_turret
{
	maxHp = _hp*2;
	attack_rate = _rate*2;
	attack_damage = _dam*2;
}