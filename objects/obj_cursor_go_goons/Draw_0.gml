depth=-room_height
var poi_size=size
var poi_frame=frame_real

if special_poi_texture
{
	poi_frame=0
	poi_size=1


}


if array_length(goto_list)==1
{
	if special_poi_texture
	{
		draw_sprite_ext(point_of_interest_texture,poi_frame,goto_list[0][0]-8,goto_list[0][1]-8,poi_size,poi_size,0,c_white,alpha_real)
	}
	else
	{
		draw_sprite_ext(point_of_interest_texture,frame_real,goto_list[0][0],goto_list[0][1],size,size,0,c_white,alpha_real)
	}
	exit
}




var _direction=point_direction(goto_list[0][0],goto_list[0][1],goto_list[1][0],goto_list[1][1])
for (var i=0;i<array_length(goto_list);i++)
{
	if !i+1==array_length(goto_list)
	{
	
		_direction=point_direction(goto_list[i][0],goto_list[i][1],goto_list[i+1][0],goto_list[i+1][1])
	}
	var list_i=goto_list[i]
	draw_sprite_ext(spr_goto_line_intersection,frame_real,goto_list[i][0],goto_list[i][1],size,size,_direction,c_white,alpha)
	frame_real+=1

}
_direction=point_direction(goto_list[0][0],goto_list[0][1],goto_list[1][0],goto_list[1][1])
frame_real=floor(frame)
var last_i=array_length(goto_list)-1
for (var i=0;i<array_length(goto_list);i++)
{
	
	if i==0
	{
		if !point_distance(goto_list[0][0],goto_list[0][1],goto_list[last_i][0],goto_list[last_i][1])<=points_dist*1.5
		{
			draw_sprite_ext(spr_goto_line_begin,frame_real,goto_list[i][0],goto_list[i][1],size,size,_direction,c_white,alpha)
		}
	}
	else if i==last_i
	{
		if point_distance(goto_list[0][0],goto_list[0][1],goto_list[i][0],goto_list[i][1])<=points_dist*1.5
		{
			
			_direction=point_direction(goto_list[i][0],goto_list[i][1],goto_list[0][0],goto_list[0][1])
			draw_sprite_ext(spr_goto_line,frame_real,goto_list[i][0],goto_list[i][1],size,size,_direction,c_white,alpha)
		}
		else
		{
			draw_sprite_ext(spr_goto_line_end,frame_real,goto_list[i][0],goto_list[i][1],size,size,_direction,c_white,alpha)
		}
		if array_length(points_of_interest)==0
		{
			if special_poi_texture
			{
				draw_sprite_ext(point_of_interest_texture,poi_frame,goto_list[i][0]-8,goto_list[i][1]-8,poi_size,poi_size,0,c_white,alpha)
			}
			else
			{
				draw_sprite_ext(point_of_interest_texture,frame_real,goto_list[i][0],goto_list[i][1],size,size,0,c_white,alpha)
			}
		}
	}
	else
	{
		_direction=point_direction(goto_list[i][0],goto_list[i][1],goto_list[i+1][0],goto_list[i+1][1])
	}
	var list_i=goto_list[i]
	draw_sprite_ext(spr_goto_line,frame_real,goto_list[i][0],goto_list[i][1],size,size,_direction,c_white,alpha)
	frame_real+=1
	
}

for (var i=0;i<array_length(points_of_interest);i++)
{

	var list_i=points_of_interest[i]
	if special_poi_texture
	{
		draw_sprite_ext(point_of_interest_texture,poi_frame,points_of_interest[i][0]-8,points_of_interest[i][1]-8,poi_size,poi_size,0,c_white,alpha_real)
	}
	else
	{
		draw_sprite_ext(point_of_interest_texture,frame_real,points_of_interest[i][0],points_of_interest[i][1],size,size,0,c_white,alpha_real)
	}
	frame_real+=1

}