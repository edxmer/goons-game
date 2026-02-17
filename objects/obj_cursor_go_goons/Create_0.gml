point_of_interest_nearby_points=10
point_of_interest_needed_points=3
point_of_interests_min_diff=20
idle_time_place_poi=1
max_points_of_interest=-1
point_of_interest_texture=spr_goto_point
special_poi_texture=false
started_with_gridmode=false
can_poi_be_placed=function(xx,yy,sprite)
{
	return true
}


if global.grid_mode
{
	can_poi_be_placed=item_special_data_get_can_place_function(global.grid_mode_item)
	max_points_of_interest=global.grid_mode_max_points_of_interests
	if global.grid_mode_sprite!=spr_empty
	{
		special_poi_texture=true
		point_of_interest_texture=global.grid_mode_sprite
	}
	started_with_gridmode=true
	point_of_interest_nearby_points=3
	point_of_interest_needed_points=2
	idle_time_place_poi=0.5
	point_of_interests_min_diff=15
	x=clamp_to_grid_middle(x)
	y=clamp_to_grid_middle(y)
}

goto_list=[[x,y]]
points_dist=8
frame=0
frame_speed=0.34
alpha_real=0.8
alpha=alpha_real

size=1
size_change=0.04
max_size=1.24
max_size_one=1.6
max_size_real=max_size_one

points_of_interest=[]

return_positions=[]

idle_time=0


frame_real=floor(frame)
death_mode=false



death_data_push=function()
{
	death_mode=true
	var poi=true
	return_positions=[]
	for (var i=0;i<array_length(points_of_interest);i++)
		{
			array_push(return_positions,points_of_interest[i])
		}
	if array_length(points_of_interest)==0
	{
		
		poi=false
		return_positions=[]
		for (var i=0;i<array_length(goto_list);i++)
		{
			array_push(return_positions,goto_list[i])
		}
		
	}
	if array_length(return_positions)==1
	{
		poi=true
	}
	
	return [return_positions,poi,started_with_gridmode]

}

create_point_of_interest=function(position)
{
	if global.grid_mode && !global.gridmode_placeable
	{
		return false
	}
	array_push(points_of_interest,position)
	particle_point_of_interest(position[0],position[1])
	if max_points_of_interest!=-1 && max_points_of_interest<array_length(points_of_interest)
	{
		array_delete(points_of_interest,0,1)
	}
}

can_create_poi=function(curr_pos)
{
	if global.grid_mode
	{
		if round(curr_pos[0])%16!=8 || round(curr_pos[1])%16!=8
		{
			return false
		}
	}
	var create_poi=true
	for (var j=0;j<array_length(points_of_interest);j++)
	{
		var other_pos=points_of_interest[j]
		if point_in_circle(other_pos[0],other_pos[1],curr_pos[0],curr_pos[1],point_of_interests_min_diff)
		{
			create_poi=false
			return false
		}
	}
	return create_poi

}