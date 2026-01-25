if !assigned
{
	assign()
}

if spawning{
	spawning_time-=delta_time/1000000
	if spawning_time<=0
	{
		set_spawning_timer()
		sound_play_category_at(summon_sound,x,y)
		summon_item_from_pool(spawn_item_pool)
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
			summon_item_from_pool(crafting_reward_pool)
			
		
		}
	
	
	}
	items_nearby_last=items_around_cnt



}

if !selected && point_in_rectangle(mouse_x,mouse_y,bbox_left-10,bbox_top-10,bbox_right+10,bbox_bottom+10)
{
	selected=true

}
else if selected && !point_in_rectangle(mouse_x,mouse_y,bbox_left-10,bbox_top-10,bbox_right+10,bbox_bottom+10)
{
	selected=false
}