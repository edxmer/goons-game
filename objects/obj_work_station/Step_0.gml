if !assigned
{
	assign()
}

if spawning{
	spawning_time-=delta_time/1000000
	if spawning_time<=0
	{
		set_spawning_timer()
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
			
			summon_item_from_pool(crafting_reward_pool)
			
		
		}
	
	
	}
	items_nearby_last=items_around_cnt



}