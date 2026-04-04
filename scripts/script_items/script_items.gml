function draw_item(_x,_y,item_id,scale,alpha=1,shadow=false,animated=false)
{
	var im_index=0
	var sprite=item_get_sprite(item_id)
	if animated
	{
		im_index=floor((current_time / 1000) * sprite_get_speed(sprite)) % sprite_get_number(sprite)
	}

	if shadow
	{
		draw_shadow_param(_x,_y+scale*(sprite_get_bbox_bottom(sprite)-sprite_get_yoffset(sprite)),scale)
	}
	draw_sprite_ext(sprite,im_index,_x,_y,scale,scale,0,c_white,alpha)

}

function item_get_sprite(item_id)
{
	return assign_item(item_id).texture
}

function item_get_held_sprite(item_id)
{
	return assign_item(item_id).held_texture
}

function item_get_ground_sound(item_id)
{
	return assign_item(item_id).ground_sound
}


function item_get_name(item_id)
{
	return assign_item(item_id).name
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
function item_get_particle_sprite(item_id)
{
	return assign_item(item_id).particle_texture
}
function item_id_summon_particles(item_id,xx,yy)
{
	particle_summon_from_texture_multiple(xx,yy,item_get_particle_sprite(item_id),irandom_range(6,8))
}

function item_id_summon_particles_less(item_id,xx,yy)
{
	particle_summon_from_texture_multiple(xx,yy,item_get_particle_sprite(item_id),irandom_range(1,2))
}

function create_item(_x,_y,item_id,put_down_by_goon=false,staydata=[])
{
	var item=instance_create_depth(_x,_y,depth,obj_item)
	item.item_id=item_id
	item.item_stay_data=staydata
	item.put_down_by_goon=put_down_by_goon
	return item
}


function item_get_collisions(_id,fromworkstations=true,fromitems=true)
{
	var idlist=ds_list_create()
	var amount=0
	if fromitems{
		with (_id)
		{
			amount=collision_rectangle_list(x-4,y-4,x+4,y+4,obj_item,false,true,idlist,true)
		}
	}
	var reallist=[]
	
	for (var i=0;i<amount;i++)
	{
		array_push(reallist,ds_list_find_value(idlist,i))
		
	}
	if fromworkstations{
		with (_id)
		{
			amount=collision_rectangle_list(x-4,y-4,x+4,y+4,obj_work_station,false,true,idlist,true)
		}
	}
	for (var i=0;i<amount;i++)
	{
		array_push(reallist,ds_list_find_value(idlist,i))
		
	}
	ds_list_destroy(idlist)
	return reallist

}

function item_move_from_collisions(_id,loop=1,collisions=[],donotdisturb=[])
{
	var baseamount=irandom_range(1,3)
	if array_length(item_get_collisions(_id,true,false))>0
	{
		baseamount=0
	}
	var goto_still=[]
	if loop>2
	{
		return
	}
	var idlist=collisions
	if array_length(collisions)==0
	{
	idlist=item_get_collisions(_id)
	}
	for(var i=0;i<array_length(idlist);i++)
	{
		if array_length(idlist)>10
		{
			break
		}
		var amount=baseamount
		
		var otheritem=idlist[i]
		if otheritem.object_index==obj_work_station
		{
			amount=5
		}
		else if baseamount==0
		{
			item_move_from_collisions(otheritem,loop+1,_id,[_id])
		}
		
		if otheritem.x>_id.x
		{
			_id.x-=amount

		}
		else
		{
			_id.x+=amount

		}
		
		if otheritem.y>_id.y
		{
			_id.y-=amount

		}
		else
		{
			_id.y+=amount


		}

		if otheritem.object_index==obj_item
		{
			array_push(goto_still,otheritem)
		}

	}
	
	for (var i=0;i<array_length(goto_still);i++)
	{
		var otheritem=goto_still[i]
		if !array_contains(donotdisturb,otheritem){
			item_move_from_collisions(otheritem,loop+1,_id,[_id])
		}
	}

}



function item_special_data_get_can_place_function(item_id)
{
	if variable_struct_exists(assign_item(item_id).special_data,"grid_mode_placeable_function")
	{
		return variable_struct_get(assign_item(item_id).special_data,"grid_mode_placeable_function")
	}
	else
	{
		var empty_funct=function(xx,yy,sprite)
		{
			return true
		}
		return empty_funct
	}
}




function item_id_get_equip_sprites(item_id)
{
	var item_data=assign_item(item_id)
	if variable_struct_exists(item_data.special_data,"equipped_sprites")
	{
		return item_data.special_data.equipped_sprites
	}
	else
	{
		return [spr_empty,spr_empty]
	}

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
	if variable_struct_exists(assign_item(item_id).special_data,special_data_name)
	{
		return variable_struct_get(assign_item(item_id).special_data,special_data_name)
	}
	else
	{
		return "empty"
	}
}




function is_item_nearby(px,py,distance=35)
{
	var items=pickuppable_enemies(px,py,distance)
	if array_length(items)>0
	{
		return true
	}
	with(obj_item)
	{
		if !(array_contains(tags,"danger") &&global.goon_count==1){
		
		
			var dist=point_distance(x,y,px,py)
			if array_contains(tags,"crafted") && dist<=distance
			{
				dist-=8
			}
			if dist<=distance && size>=1 && !array_contains(tags,"unpickuppable"){
				return true
			}
		}
	}
	
	return false
}

function nearby_itemslist(px,py,distance=35)
{
	var items=pickuppable_enemies(px,py,distance)
	
	with(obj_item)
	{
		if !(array_contains(tags,"danger") &&global.goon_count==1){
		
		
			var dist=point_distance(x,y,px,py)
			if array_contains(tags,"crafted") && dist<=distance
			{
				dist-=8
			}
			if dist<=distance && size>=1 && !array_contains(tags,"unpickuppable"){
				array_push(items,[id,dist,item_id,"item",item_stay_data])
			}
		}
	}
	
	return items
}

function pickup_item(px,py,pickup_distance=35)
{
	var items=nearby_itemslist(px,py,pickup_distance)
	
	
	var min_distance=10000
	var current_min=0
	if array_length(items)==0{
		return ["empty",[]]
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
	if min_dist_item[3]=="item"
	{
		item_picked_up(min_dist_item[0])
	}
	else
	{
		enemy_picked_up(min_dist_item[0])
	}
	return [min_dist_item[2],min_dist_item[4]]
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



