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


function goon_if_gooning_goto_coords(_id,xx,yy){
	with(_id){
		if gooning{
			var distance=point_distance(x,y,mouse_x,mouse_y)
			var look=point_direction(x,y,mouse_x,mouse_y)
			if distance<6
			{
				put_down_item()
			}
			
			var bad_prec=min(distance*0.2,15)
			goto_x=mouse_x+irandom_range(-bad_prec,bad_prec)
			goto_y=mouse_y+irandom_range(-bad_prec,bad_prec)
			if dumb{
				goto_x=x+lengthdir_x(-distance,look)
				goto_y=y+lengthdir_y(-distance,look)
			}
				
			goto_x=clamp(goto_x,8,room_width-8)
			goto_y=clamp(goto_y,8,room_height-8)
			gooning=false
		}
	}

}