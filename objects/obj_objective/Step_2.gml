level=global.reward_level
if (!first_end_step) {
	
	if !second_happened{
		possible_items = workstation_get_all_possible_items()
		generate_objective_items()
		second_happened=true
	}
}