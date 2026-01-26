if global.reward_mode==false{
	with(obj_objective)
	{
		generate_objective_items()
	}
	
instance_destroy(obj_reward_one)
instance_destroy()
}