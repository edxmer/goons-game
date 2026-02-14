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

point_of_interest_nearby_points=10
point_of_interest_needed_points=3
point_of_interests_min_diff=40

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
	
	return [return_positions,poi]

}

create_point_of_interest=function(position)
{
	array_push(points_of_interest,position)
	particle_point_of_interest(position[0],position[1])
}