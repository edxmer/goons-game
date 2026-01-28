if !assigned
{
	assign()
}

if primordeal_goo{
	crafting_input_ids=global.objective_list
}

if spawning{
	spawning_time-=delta_time/1000000
	if spawning_time<=0
	{
		set_spawning_timer()
		sound_play_category_at(summon_sound,x,y)
		var pool=spawn_item_pool
		var nearby=get_nearby_item_ids()
		var amount=0
		for (var i=0;i<array_length(nearby);i++)
		{
			if array_contains(pool,nearby[i])
			{
				amount++
			}
		}
		if amount<10{
			summon_item_from_pool(spawn_item_pool)
		}
		else{
			spawning_time/=2
		}
	}
}

if crafting
{
	var items_nearby=get_nearby_item_ids()
	var items_around_cnt=array_length(items_nearby)
	if items_nearby_last!=items_around_cnt
	{
		if list_contains_sublist(items_nearby, crafting_input_ids)
		{
			for (var i=0;i<array_length(crafting_input_ids);i++)
			{
				var cur_item=crafting_input_ids[i]
				item_destroy_nearby(cur_item)
			}
			sound_play_category_at(craft_sound,x,y)
			var closest=goons_get_closest_idle(x,y)
			if closest!=noone && point_distance(closest.x,closest.y,x,y)<=40 && closest.inventory=="empty"
			{
				var item=get_item_from_pool(crafting_reward_pool)
				closest.inventory=item
				closest.inventory_sprite=assign_item(item).texture
			}
			else{
				summon_item_from_pool(crafting_reward_pool)
			}
			
		
		}
	
	
	}
	items_nearby_last=items_around_cnt



}

if !selected && point_in_rectangle(mouse_x,mouse_y,bbox_left-5,bbox_top-10,bbox_right+5,bbox_bottom+5)
{
	sound_play_category_at("swoosh",x,y)
	selected=true

}
else if selected && !point_in_rectangle(mouse_x,mouse_y,bbox_left-5,bbox_top-10,bbox_right+5,bbox_bottom+5)
{
	sound_play_category_at("swoosh",x,y)
	selected=false
}