function draw_item(_x,_y,item_id,scale)
{
	var sprite=assign_item(item_id).texture
	draw_sprite_ext(sprite,0,_x,_y,scale,scale,0,c_white,1)

}


function create_item(_x,_y,item_id)
{
	var item=instance_create_depth(_x,_y,depth,obj_item)
	item.item_id=item_id
}

function assign_item(item_id){
	var item_data={texture:spr_empty,item_id:"empty",tags:[]}
	item_data.item_id=item_id
	array_push(item_data.tags,item_id)
	if item_id=="logs"{
		item_data.texture=spr_logs
	array_push(item_data.tags,"wood")
	}if item_id=="plank"{
		item_data.texture=spr_plank
	array_push(item_data.tags,"wood")
	}
	else if item_id=="cigarette"{
		item_data.texture=spr_cigarette
	}
	else if item_id=="rock"{
		item_data.texture=spr_rock
		array_push(item_data.tags,"stone")
	}
	else if item_id=="banana"{
		item_data.texture=spr_banana
		array_push(item_data.tags,"trash")
	}
	else if item_id=="sock"{
		item_data.texture=spr_sock
		array_push(item_data.tags,"trash")
	}
	
	return item_data
}


function pickup_item(px,py,pickup_distance=20)
{
	var items=[]
	with(obj_item)
	{
		var dist=point_distance(x,y,px,py)
		if dist<=pickup_distance && size>=1{
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



function items_scatter_start_of_game(item_pool,item_amount)
{
	for(var i=0;i<item_amount;i++)
	{
		var item_curr=item_pool[irandom_range(0,array_length(item_pool)-1)]
		create_item(irandom_range(16,room_width-16),irandom_range(16,room_height-16),item_curr)
	}

}



