// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function approach(a,b,amt)
{
	if (a != b)
	{
		if (a > b)
		{
			a -= amt;
			
			if (a < b) then a = b;
		}
		else if ( a < b )
		{
			a += amt;
			
			if (a > b) then a = b;
		}
	}
	
	return a;
}
