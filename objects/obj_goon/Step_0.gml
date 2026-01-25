
if goto_x!=x && goto_y!=y{
	var look=point_direction(x,y,goto_x,goto_y)

	x+=lengthdir_x(goon_speed,look)
	var lookx=sign(lengthdir_x(goon_speed,look))
	if lookx!=0{
		image_xscale=lookx
	}
	
	y+=lengthdir_y(goon_speed,look)

	if point_distance(x,y,goto_x,goto_y)<goon_speed{
		goto_x=x
		goto_y=y
		interact_function()
	}
}


