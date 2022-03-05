/// @description HEAL
// You can write your code in this editor
if hp < maxHp then hp += 1;
alarm[0] = room_speed*2;

if (global.is_host)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "core_hp_sync";
	_d[? "hp"] = hp;
	_d[? "alarm_time"] = alarm[0];
	send_data(_d);
}