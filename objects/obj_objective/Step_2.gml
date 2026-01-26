level=global.reward_level
if (!first_end_step) {
	first_end_step = true
	possible_items = workstation_get_all_possible_items()
	generate_objective_items()
}