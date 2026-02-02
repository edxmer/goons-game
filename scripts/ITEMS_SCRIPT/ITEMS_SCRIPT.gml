function draw_item(_x,_y,item_id,scale)
{
	var sprite=item_get_sprite(item_id)
	draw_sprite_ext(sprite,0,_x,_y,scale,scale,0,c_white,1)

}

function item_get_sprite(item_id)
{
	return assign_item(item_id).texture
}

function item_send_particles(_id_of_item)
{
	with(_id_of_item)
	{
		if object_index==obj_item{
			item_id_summon_particles(item_id,x,y)
		}
	}
}

function item_id_summon_particles(item_id,xx,yy)
{
	particle_summon_from_texture_multiple(xx,yy,item_get_sprite(item_id),irandom_range(6,8))
}


function create_item(_x,_y,item_id)
{
	var item=instance_create_depth(_x,_y,depth,obj_item)
	item.item_id=item_id
}

function assign_item(item_id){
	var item_data={texture:spr_empty,item_id:"empty",name:"empty",tags:[],special_data:{}}
	item_data.item_id=item_id
	item_data.name=string_upper(string_copy(item_id,1,1))+ string_replace_all(string_copy(item_id,2,string_length(item_id)-1),"_"," ")
	array_push(item_data.tags,item_id)
	if string_copy(item_id,1,8)=="station-"{
		//station-woodcutter
		var _station_id=string_copy(item_id,9,string_length(item_id)-8)//(string_split(item_data,"-")[1])
		item_data.name=work_station_data_get(_station_id).name
		item_data.texture=work_station_texture_get(_station_id)
		array_push(item_data.tags,"station")
	}
	if item_id=="logs"{
		item_data.texture=spr_logs
	array_push(item_data.tags,"wood")
	
	}
	if item_id=="frog"{
		item_data.texture=spr_frog
	}
	if item_id=="candy"{
		item_data.texture=spr_candy
		array_push(item_data.tags,"crafted")
	}
	if item_id=="ice_cream"{
		item_data.texture=spr_ice_cream
		item_data.special_data.freezing_pixel_amount=200
		array_push(item_data.tags,"freezing")
		array_push(item_data.tags,"has_effects")
		array_push(item_data.tags,"danger")
	}
	if item_id=="froglamp"{
		item_data.texture=spr_froglamp
		array_push(item_data.tags,"crafted")
	}
	if item_id=="plank"{
		item_data.texture=spr_plank
	array_push(item_data.tags,"wood")
		array_push(item_data.tags,"crafted")
	}
	if item_id=="lamp"{
		item_data.texture=spr_lamp
		array_push(item_data.tags,"crafted")
	}
	if item_id=="hammer"{
		item_data.texture=spr_hammer
		array_push(item_data.tags,"pick_up_building")
		array_push(item_data.tags,"has_effects")
		//array_push(item_data.tags,"persistent")
	}
	if item_id=="goon_blue"{
		item_data.texture=spr_goon_blue
		array_push(item_data.tags,"unpickuppable")
	}
	if item_id=="goon_show_dumb"{
		item_data.texture=spr_goon_dumb
		array_push(item_data.tags,"unpickuppable")
	}
	else if item_id=="cigarette"{
		item_data.texture=spr_cigarette
		array_push(item_data.tags,"crafted")
	}
	else if item_id=="rock"{
		item_data.texture=spr_rock
		array_push(item_data.tags,"stone")
	}
	else if item_id=="banana"{
		item_data.texture=spr_banana
		array_push(item_data.tags,"trash")
	}
	else if item_id=="goo"{
		item_data.texture=spr_goo_yellow
		array_push(item_data.tags,"crafted")
	}
	else if item_id=="goon_show"{
		item_data.texture=spr_goon
		array_push(item_data.tags,"unpickuppable")
	}
	else if item_id=="goon_show_blue"{
		item_data.texture=spr_goon_blue
		array_push(item_data.tags,"unpickuppable")
	}
	else if item_id=="reward"{
		item_data.texture=spr_reward
		array_push(item_data.tags,"unpickuppable")
	}
	else if item_id=="sock"{
		item_data.texture=spr_sock
		array_push(item_data.tags,"trash")
	}
	
	return item_data
}

function item_tags_contains(item_id,tag)
{
	return array_contains(item_get_tags(item_id),tag)
}

function item_unpickupable(item_id)
{
	return array_contains(item_get_tags(item_id),"unpickuppable")
}

function item_get_tags(item_id)
{
	return assign_item(item_id).tags
	
}

function item_special_data_contains(item_id,special_data_name)
{
	return variable_struct_exists(assign_item(item_id).special_data,special_data_name)
}
function item_special_data_get(item_id,special_data_name)
{
	return variable_struct_get(assign_item(item_id).special_data,special_data_name)
}


function pickup_item(px,py,pickup_distance=35)
{
	var items=[]
	with(obj_item)
	{
		if !(array_contains(tags,"danger") &&global.goon_count==1){
		
		
			var dist=point_distance(x,y,px,py)
			if array_contains(tags,"crafted") && dist<=pickup_distance
			{
				dist-=8
			}
			if dist<=pickup_distance && size>=1 && !array_contains(tags,"unpickuppable"){
				array_push(items,[id,dist,item_id])
			}
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
		create_item(irandom_range(16,room_width-16),irandom_range(100,global.room_height-16),item_curr)
	}

}



