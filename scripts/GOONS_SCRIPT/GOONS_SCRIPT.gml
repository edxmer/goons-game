function goons_get_closest_idle(xx,yy){
	var goonslist=[]
	with(obj_goon)
	{
		if goon_is_idle(id)
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

function goon_is_idle(_id)
{
	if _id.object_index==obj_goon{
		if _id.gooning==false && _id.inventory=="empty" && _id.goto_x==_id.x && _id.goto_y==_id.y
		{
			return true
		}
	}
	return false
}