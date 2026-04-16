image_xscale=xscale_base*size*xscale_turn
image_yscale=yscale_base*size
sprite_index=sprite

var dt=(delta_time/1000000)

if invincibility>0
{
	invincibility=max(invincibility-dt,0)
}

if timer1>0
{
	timer1=max(0,timer1-dt)
}

if locate_object && instance_exists(located_object)
{
	goto_x=located_object.x 
	goto_y=located_object.y
}

_curr_speed=movement_speed_per_second*movement_modificator*dt
reached_destination_this_frame=false

if abs(goto_x-x)<_curr_speed && abs(goto_y-y)<_curr_speed
{
	x=goto_x
	y=goto_y
	idle=true

}
else
{
	var look=point_direction(x,y,goto_x,goto_y)
	x+=lengthdir_x(_curr_speed,look)
	y+=lengthdir_y(_curr_speed,look)
	if turn_left_right && lengthdir_x(_curr_speed,look)!=0
	{
		xscale_turn=sign(lengthdir_x(_curr_speed,look))
	}
	idle=false
	if abs(goto_x-x)<_curr_speed && abs(goto_y-y)<_curr_speed
	{
		reached_destination_this_frame=true
	}
}

if idle
{
	idle_time+=dt
}
else
{
	idle_time=0
}

if point_in_rectangle(mouse_x,mouse_y,bbox_left,bbox_top,bbox_right,bbox_bottom)
{
	selected=true
	var testlist=[obj_goon,obj_item,obj_work_station]
	for (var i=0;i<array_length(testlist);i++)
	{
		var _obj=testlist[i]
		with(_obj)
		{
			if selected
			{
				other.selected=false
			}
		}
	}
	


}
else
{
	selected=false
}


if hp<=0
{
	enemy_die()
	exit

}