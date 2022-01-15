/// @description Insert description here
// You can write your code in this editor
if (instance_exists(follow_this))
{
	var _dist = point_distance(x,y,follow_this.x,follow_this.x);
	
	if (_dist > 0.5)
	{
		var _spd = _dist * 0.1;
		//x = follow_this.x;
		//y = follow_this.y;
		x = approach(x, follow_this.x, _spd );
		y = approach(y, follow_this.y, _spd );
	}
	else
	{
		x = follow_this.x;
		y = follow_this.y;
	}
}

//Snap the view
camera_set_view_pos(local_camera,x - view_wport[0]/2,y - view_hport[0]/2);