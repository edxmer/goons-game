if selected{
		if crafting{
		if spawning{
			draw_both_information(bbox_left-30,y-40,crafting_input_ids,crafting_reward_pool,spawn_item_pool)
		}
		else{
			draw_craft_information(bbox_left-30,y-40,crafting_input_ids,crafting_reward_pool)
		}
	}
	else if spawning
	{
			draw_summon_information (bbox_left-30,y-40,spawn_item_pool)
		
	}


}