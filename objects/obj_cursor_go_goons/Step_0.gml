var amount=array_length(goto_list)

var x_curs=mouse_x
var y_curs=mouse_y




if global.grid_mode
{
	x_curs=clamp_to_grid_middle(x_curs)
	y_curs=clamp_to_grid_middle(y_curs)
	
	global.gridmode_placeable=can_poi_be_placed(clamp_to_grid_start(x_curs),clamp_to_grid_start(y_curs)+16,point_of_interest_texture)
	
}
if !death_mode
{
	var last_step=array_last(goto_list)
	var distance=point_distance(x_curs,y_curs,last_step[0],last_step[1])
	if distance>=points_dist
	{
		idle_time=0
		var dir=point_direction(x_curs,y_curs,last_step[0],last_step[1])
		var xx=x_curs
		var yy=y_curs
		var dir_points=[]
		for (var i=0;i<distance;i+=points_dist)
		{
			array_push(dir_points,[xx,yy])
			xx+=lengthdir_x(points_dist,dir)
			yy+=lengthdir_y(points_dist,dir)
		}
		for (var i=array_length(dir_points)-1;i>=0;i--)
		{
			array_push(goto_list,dir_points[i])
		}
	}
	else
	{
		idle_time+=delta_time/1000000
		if idle_time>=idle_time_place_poi
		{
			var curr_pos=array_last(goto_list)
			var create_poi=can_create_poi(curr_pos)

			if create_poi
			{
				create_point_of_interest(curr_pos)
		
			}
			else if !global.grid_mode
			{
				set_to_next_point_of_interest_other(curr_pos)
			}
			idle_time=0
		}
	
	}
	
	if amount<array_length(goto_list) && amount>15
	{
		for (var i=amount;i<array_length(goto_list);i++)
		{
			var nearby=0
			var curr_pos=goto_list[i]
			for (var j=0;j<i-5;j++)
			{
				var other_pos=goto_list[j]
				if point_in_circle(other_pos[0],other_pos[1],curr_pos[0],curr_pos[1],point_of_interest_nearby_points)
				{
					nearby++
				}
			}
			if nearby>=point_of_interest_nearby_points
			{
				var create_poi=can_create_poi(curr_pos)
				if create_poi
				{
					create_point_of_interest(curr_pos)
					/*array_push(points_of_interest,curr_pos)
					particle_point_of_interest(curr_pos[0],curr_pos[1])*/
				
				}
			}
	
	
		}
	}
}

if array_length(points_of_interest)>0
{
	if alpha>0.3
	{
		alpha-=0.05
	}
}




if !mouse_check_button(mb_left) && !death_mode
{
	death_data_push()
	
}

if death_mode
{
	//frame+=frame_speed*0.8
	frame_real=floor(frame)
	alpha_real-=0.035
	if alpha_real<alpha{
		alpha=alpha_real
	}
	size+=0.04
	if array_length(goto_list)==1
	{
		size+=0.025
	}
	if alpha_real<=0
	{
		instance_destroy()
	}
	
}
else
{
	frame+=frame_speed
	frame_real=floor(frame)
	
	if array_length(goto_list)==1
	{
		
	}
	size+=size_change
	
	if size>=max_size || size<=1
	{
		size_change*=-1
	}
}

