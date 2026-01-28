crafting=false
spawning=false
primordeal_goo=false

used_amount=0
destroy_after=-1


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


craft_sound="empty"
summon_sound="empty"
	
assigned=false

assign=function()
{
	assigned=true
	var station_data=work_station_data_get(station_id)

	sprite_index=station_data.texture
	
	destroy_after=station_data.destroy_after
	
	onemore_chance=station_data.third
	
	crafting=station_data.crafting
	spawning=station_data.spawning
	primordeal_goo=station_data.primordeal_goo
	
	craft_sound=station_data.craft_sound
	summon_sound=station_data.summon_sound
	
	spawning_timer=station_data.spawn_timer_sec
	spawn_item_pool=station_data.spawn_item_pool
	

	crafting_reward_pool=station_data.craft_reward_pool
	crafting_input_ids=station_data.craft_input_pool_tags

	set_spawning_timer()
}

set_spawning_timer=function()
{
	spawning_time=irandom_range(spawning_timer[0],spawning_timer[1])
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
		create_item(irandom_range(bbox_left-10,bbox_right+10),irandom_range(bbox_bottom,bbox_bottom+10),item)}
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
	var x_min=bbox_left-40
	var x_max=bbox_right+40
	var y_min=bbox_top-30
	var y_max=bbox_bottom+50
	var deleted=false
	with (obj_item){
		if point_in_rectangle(x,y,x_min,y_min,x_max,y_max)
		{
			if !deleted && item_id_delete==item_id
			{
				deleted=true
				instance_destroy()
			}
		}
	}

}