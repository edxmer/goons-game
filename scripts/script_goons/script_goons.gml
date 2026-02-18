function create_goon(_x,_y)
{
	return instance_create_depth(_x,_y,0,obj_goon)
}


function draw_shadow()
{
	draw_sprite_ext(spr_shadow,0,x,bbox_bottom,image_xscale,image_yscale,0,c_white,image_alpha)
}

function goons_get_closest_idle(xx,yy,items=["empty"]){
	var goonslist=[]
	with(obj_goon)
	{
		if goon_is_idle(id,items) && id.dumb==false
		{
			array_push(goonslist,[id,point_distance(x,y,xx,yy)])
		}
	}
	if array_length(goonslist)==0
	{
		return noone
	}
	else
	{
		var min_id=noone
		var mindistance=1000000
		for(var i=0;i<array_length(goonslist);i++)
		{
			if goonslist[i][1]<=mindistance
			{
				mindistance=goonslist[i][1]
				min_id=goonslist[i][0]
			}
		}
		return min_id
	}
	
}
function goons_get_closest_gooning(xx,yy){
	var goonslist=[]
	with(obj_goon)
	{
		if gooning
		{
			array_push(goonslist,[id,point_distance(x,y,xx,yy)])
		}
	}
	if array_length(goonslist)==0
	{
		return noone
	}
	else
	{
		var min_id=noone
		var mindistance=1000000
		for(var i=0;i<array_length(goonslist);i++)
		{
			if goonslist[i][1]<=mindistance
			{
				mindistance=goonslist[i][1]
				min_id=goonslist[i][0]
			}
		}
		return min_id
	}
	
}


function goon_is_idle(_id,items=["empty"])
{
	if _id.object_index==obj_goon{
		if _id.gooning==false && array_contains(items,_id.inventory) && abs(_id.goto_x-_id.x)<_id.goon_speed && abs(_id.goto_y-_id.y)<_id.goon_speed
		{
			return true
		}
	}
	return false
}


function gooning_goons_count()
{
	var count=0
	with (obj_goon)
	{
		if gooning{
			count++
		}
	}
	return count
}


function goon_if_gooning_goto_coords(_id,xx,yy,list_of_interests=[],stop_at_every_point=false,fromgridmode=false){
var interact="interact"
if fromgridmode
{
	if !global.gridmode_placeable && !stop_at_every_point
	{
		interact="nothing"
		
	}
	{
		interact="gridmode_useitem"
	}
}
	with(_id){
		if gooning{
			if gooning_goons_count()==1 && array_length(list_of_interests)!=0
			{
				
				gooning=false
				if !stop_at_every_point
				{
					goto_x=x 
					goto_y=y
					goto_list=list_of_interests
					
					array_push(goto_list,interact)
				
				
				}
				else
				{
					goto_x=x 
					goto_y=y
					goto_list=[]
					var start=[x,y]
					for(var i=0;i<array_length(list_of_interests);i++)
					{
						//show_message(list_of_interests[i])
						var goto_mid=pathfind_fix_points(start,list_of_interests[i])
						for (var j=0;j<array_length(goto_mid);j++)
						{
							array_push(goto_list,goto_mid[j])
						}
						if fromgridmode || array_length(list_of_interests[i])<3
						{
							array_push(goto_list,interact)
						}
						else
						{
							array_push(goto_list,list_of_interests[i][2])
						}
						start=list_of_interests[i]
						
					}
					
					
				}
				return
			
			}
			else if array_length(list_of_interests)!=0
			{
				if stop_at_every_point
				{
					var gave_goons=[]
					
					while gooning_goons_count()>0
					{
						for (var p=0;p<array_length(list_of_interests);p++)
						{
							var curr_point=list_of_interests[p]
							if gooning_goons_count()>0
							{
								var come_id=goons_get_closest_gooning(curr_point[0],curr_point[1])
								goon_if_gooning_goto_coords(come_id,curr_point[0],curr_point[1])
								if array_length(curr_point)>2
								{
									if array_length(come_id.goto_list)==0 || is_array(array_last(come_id.goto_list))
									{
										array_push(come_id.goto_list,curr_point[2])
									}
									else if is_string(array_last(come_id.goto_list))
									{
										come_id.goto_list[array_length(come_id.goto_list)-1] =curr_point[2]
									}
								}
							}
							else
							{
								return
							}
						
						
						}
					
					
					
					}
					return
				
				
				
				
				}
				else
				{
					with(obj_goon)
					{
						if gooning{
							var closest_distance=1000000000000000000000000
							
							var closest_point=[x+1000000,y]
							var closest_points=[]
							for (var g=0;g<array_length(list_of_interests);g++)
							{
								var p_curr=list_of_interests[g]
								var curr_dist=point_distance(x,y,p_curr[0],p_curr[1])
								if curr_dist<closest_distance
								{
									closest_distance=curr_dist
									closest_point=p_curr
									
									array_push(closest_points,closest_point)
									if array_length(closest_points)>gooning_goons_count()*2
									{
										array_delete(closest_points,0,1)
									}
								}
							}
							closest_point=closest_points[irandom(array_length(closest_points)-1)]
							goon_if_gooning_goto_coords(id,closest_point[0],closest_point[1])
						}
					}
					return
				
				
				}
			
			
			}
			var feet_dist=(bbox_bottom-y)*0.6
			yy-=feet_dist
			var direct_to_item=false
			with (obj_item)
			{
				if selected
				{
					xx=x 
					yy=y 
					direct_to_item=true
				}
			}
			
			if place_meeting(xx,yy,obj_work_station)
			{
				direct_to_item=true
				var blook=point_direction(xx,yy,x,y)
				var maxtries=100
				while (position_meeting(xx,yy,obj_work_station) && maxtries>0)
				{
					xx+=lengthdir_x(1,blook)
					yy+=lengthdir_y(1,blook)
					maxtries--
				}
			}
			yy+=feet_dist
			var distance=point_distance(x,y,xx,yy)
			var look=point_direction(x,y,xx,yy)
			if distance<6
			{
				put_down_item()
			}
			yy-=feet_dist
			var bad_prec=min(distance*0.12,15)
			if direct_to_item || global.grid_mode
			{
				bad_prec=min(distance*0.02,1)
			}
			var _goto_x=xx+irandom_range(-bad_prec,bad_prec)
			var _goto_y=yy+irandom_range(-bad_prec,bad_prec)
			if dumb{
				_goto_x=x+lengthdir_x(-distance,look)
				_goto_y=y+lengthdir_y(-distance,look)
			}
				
			_goto_x=clamp(_goto_x,8,room_width-8)
			_goto_y=clamp(_goto_y,8,global.camera_room_height-8)
			goto_list=array_concat(goto_list,pathfind_fix_points([x,y],[_goto_x,_goto_y]))//[[_goto_x,_goto_y]]
			array_push(goto_list,"interact")
			got_new_directions=true
			gooning=false
		}
	}

}