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

function goon_is_idle(_id,items=["empty"])
{
	if _id.object_index==obj_goon{
		if _id.gooning==false && array_contains(items,_id.inventory) && _id.goto_x==_id.x && _id.goto_y==_id.y
		{
			return true
		}
	}
	return false
}

function edit_goon(id)
{
	if !global.special_mode
	{
		
		global.goon_edit_id=id
		instance_create_depth(x,y,depth,obj_edit_goon)
	}
	else if global.goon_edit_id
	{
		global.goon_edit_id=id
	}

}


function goon_if_gooning_goto_coords(_id,xx,yy){

	with(_id){
		if gooning{
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
			yy+=bbox_bottom-y
			var distance=point_distance(x,y,xx,yy)
			var look=point_direction(x,y,xx,yy)
			if distance<6
			{
				put_down_item()
			}
			
			var bad_prec=min(distance*0.12,15)
			if direct_to_item
			{
				bad_prec=min(distance*0.08,4)
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
			gooning=false
		}
	}

}