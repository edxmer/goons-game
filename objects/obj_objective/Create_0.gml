
level = 1

num_of_items_to_get = function(){
	return floor(log2(level+1))
}

currently_held_items = []

possible_items = get_all_possible_items()

generate_objective_items = function() {
	var _arr_len = num_of_items_to_get()
	global.objective_items = array_shuffle(possible_items, 0, _arr_len)
}


generate_objective_items()