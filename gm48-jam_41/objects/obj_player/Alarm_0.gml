/// @description Insert description here
// You can write your code in this editor
if (hp < maxHp) then hp += hp_regen_amt;

if (hp > maxHp) then hp = maxHp;

alarm[0] = hp_regen_rate;