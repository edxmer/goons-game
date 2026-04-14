event_inherited();
if current_ai=="find_guy"
{
	sprite=spr_homonculus
	var last_length=100000000000000000
					rolling=false
					image_angle=0
	with(obj_goon)
	{
		var len=point_distance(other.x,other.y,x,y)
		if last_length>len
		{
			other.current_guy=id
			last_length=len
		}
	}
	if current_guy!=noone
	{
		current_ai="orbit_guy"
	}
}
if current_ai=="orbit_guy"
{
	if !instance_exists(current_guy)
	{
		current_ai="find_guy"
	}
	else
	{
		if not_moving()
		{
			goto_x=current_guy.x+irandom_range(20,40)*one_or_minus_one()
			goto_y=current_guy.y+irandom_range(15,30)*one_or_minus_one()
				image_angle=0
					rolling=false
		}
		else
		{
			if ! rolling && irandom(100)==1
			{
				rolling=true
				image_angle-=10
			}
			else if rolling
			{
				image_angle-=10
				if image_angle<-360
				{
					image_angle=0
					rolling=false
				}
			
			}
		}
	
	
	}
	
}