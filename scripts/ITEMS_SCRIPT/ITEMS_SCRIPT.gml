function create_item(_x,_y,item_id)
{
	var item=instance_create_layer(_x,_y,layer,obj_item)
	item.item_id=item_id
}

function assign_item(item_id){
	var item_data={texture:spr_empty,item_id:"empty"}
	item_data.item_id=item_id
	if item_id=="logs"{
		item_data.texture=spr_logs
	}
	
	return item_data
}


function pickup_item(px,py,pickup_distance=20)
{
	var items=[]
	with(obj_item)
	{
		var dist=point_distance(x,y,px,py)
		if dist<=pickup_distance{
			array_push(items,[id,dist,item_id])
		}
	}
	var min_distance=10000
	var current_min=0
	if array_length(items)==0{
		return "empty"
	}
	for(var i=0;i<array_length(items);i++)
	{
		var cur_item= items[i]
		if min_distance >cur_item[1]
		{
			current_min=i
			min_distance=cur_item[1]
		}
	}
	
	var min_dist_item=items[current_min]
	item_picked_up(min_dist_item[0])
	return min_dist_item[2]
}


function item_picked_up(_id){
	if _id.object_index==obj_item{
		var item_id=_id.item_id
		instance_destroy(_id)
		return item_id
	}
	return "empty"
}