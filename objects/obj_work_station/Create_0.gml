crafting=false
spawning=false
growing=false



primordeal_goo=false
eating_time=0
eating_timer=0.5


name=""

used_amount=0
destroy_after=-1

has_special_crafting_output=false
special_crafting_output=["empty"]

x=clamp(x,16,room_width-16)
y=clamp(y,32,global.room_height-32)

onemore_chance=false

sprite_index=spr_empty
station_id="empty"

selected=false

crafting_reward_pool=[]
crafting_input_ids=[]

items_nearby_last=0

spawning_timer=[0,0]
spawning_time=0
spawn_item_pool=[]

grow_stage_timer=[0,0]
grow_time=0
grown_up_event=[]
growth_index=0
growth_index_reseted=0
grow_stage_sprites=[]
grow_stop=false

interact_recieve_items=[]
can_be_interacted=false
interact_destroy=false
interact_tick=0
sprite_top_part=0

craft_sound="empty"
summon_sound="empty"
	
assigned=false

interact_item_push=function(item_id)
{
	array_push(interact_recieve_items,item_id)
	interact_tick=0
}
goon_interacted=function()
{

	if can_be_interacted
	{
		for (var i=0;i<array_length(interact_recieve_items);i++)
		{
			var item=interact_recieve_items[i]
			closest=goons_get_closest_empty(x,y)
			if !item_unpickupable(item) &&closest!=noone && point_distance(closest.x,closest.y,x,y)<=40 && closest.inventory=="empty"
			{
				
				closest.inventory=item
				closest.inventory_sprite=assign_item(item).texture
			}
			else{
				
				summon_item_from_pool([item])
			}
	
		}
		interact_recieve_items=[]

	}
	if interact_destroy
	{
		instance_destroy()
		return
	}


}

change_sprite=function(sprite)
{
	sprite_index=sprite
	calculate_top_part()
}

calculate_top_part=function()
{
sprite_top_part=min(sprite_get_yoffset(sprite_index)-sprite_get_bbox_top(sprite_index), sprite_get_yoffset(sprite_index)-sprite_get_height(sprite_index))

}


assign=function()
{
	assigned=true
	var station_data=work_station_data_get(station_id)
	
	name=station_data.name
	
	change_sprite(station_data.texture)
	
	destroy_after=station_data.destroy_after
	
	onemore_chance=station_data.third
	
	crafting=station_data.crafting
	spawning=station_data.spawning
	growing=station_data.growing
	
	grow_stage_timer=station_data.grow_stage_timer
	grown_up_event=station_data.grown_up_event
	growth_index=station_data.growth_index
	grow_stage_sprites=station_data.grow_stage_sprites
	set_growing_time()
	
	
	primordeal_goo=station_data.primordeal_goo
	
	craft_sound=station_data.craft_sound
	summon_sound=station_data.summon_sound
	
	spawning_timer=station_data.spawn_timer_sec
	spawn_item_pool=station_data.spawn_item_pool
	

	crafting_reward_pool=station_data.craft_reward_pool
	if has_special_crafting_output
	{
		crafting_reward_pool=special_crafting_output
	}
	crafting_input_ids=station_data.craft_input_pool_tags

	set_spawning_timer()
	reposition()
	
	calculate_top_part()
}

get_timer_time=function(timer_list)
{
	return irandom_range(timer_list[0],timer_list[1])


}

set_growing_time=function()
{
	grow_time=get_timer_time(grow_stage_timer)
}

set_spawning_timer=function()
{
	spawning_time=get_timer_time(spawning_timer)//irandom_range(spawning_timer[0],spawning_timer[1])
}

get_item_from_pool=function(item_pool)
{
	if !array_length(item_pool)==0
	{
		return item_pool[irandom_range(0,array_length(item_pool)-1)]
	}
	return "empty"
}

summon_item_from_pool=function(item_pool)
{
	if !array_length(item_pool)==0
	{
		var item=item_pool[irandom_range(0,array_length(item_pool)-1)]
		create_item(irandom_range(bbox_left-10,bbox_right+10),irandom_range(bbox_bottom,bbox_bottom+10),item)
	}
}

get_nearby_items_with_calories=function(){
	var x_min=bbox_left-40
	var x_max=bbox_right+40
	var y_min=bbox_top-30
	var y_max=bbox_bottom+50
	var nearby_items=[]
	with (obj_item){
		if point_in_rectangle(x,y,x_min,y_min,x_max,y_max)
		{
			var calories=item_get_calories(item_id)
			if calories>0
			{
				array_push(nearby_items,[id,calories])
			}
		}
	}
	return nearby_items
}

get_nearby_item_ids=function(){
	var x_min=bbox_left-40
	var x_max=bbox_right+40
	var y_min=bbox_top-30
	var y_max=bbox_bottom+50
	var nearby_items=[]
	with (obj_item){
		if point_in_rectangle(x,y,x_min,y_min,x_max,y_max)
		{
			array_push(nearby_items,item_id)
		}
	}
	return nearby_items
}

item_destroy_nearby=function(item_id_delete)
{
	if !is_string(item_id_delete) && instance_exists(item_id_delete) && item_id_delete.object_index==obj_item
	{
		with (item_id_delete)
		{
		item_send_particles(id)
		instance_destroy()
		}
		return
	}
	var x_min=bbox_left-40
	var x_max=bbox_right+40
	var y_min=bbox_top-30
	var y_max=bbox_bottom+50
	var deleted=false
	with (obj_item){
		if point_in_rectangle(x,y,x_min,y_min,x_max,y_max)
		{
			if !deleted && item_id_delete==item_id && !item_tags_contains(item_id,"persistent")
			{
				item_send_particles(id)
				deleted=true
				instance_destroy()
			}
		}
	}

}


reposition=function()
{
	x=clamp_to_grid_start(x)
y=clamp_to_grid_start(y)

if !gridmode_check_workstation_hitboxes(x,y,sprite_index)
{

	var max_tries=20
	var look=point_direction(x,y,room_width>>1,global.room_height>>1)
	while(max_tries>=0 && !gridmode_check_workstation_hitboxes(x,y,sprite_index))
	{
		x+=lengthdir_x(-5,look)
		y+=lengthdir_y(-5,look)
		max_tries--
	}
}
x=clamp(x,16,room_width-16)
y=clamp(y,70,global.room_height-32)

x=clamp_to_grid_start(x)
y=clamp_to_grid_start(y)
}