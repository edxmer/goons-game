
level = 67

currently_held_items = []

possible_items = []
first_end_step = false


x = 50
y = 40
height = 110
width = 100
outline = 5
dist_between_items = width-outline



num_of_items_to_get = function(){
	return floor(log2(level+1))
}

generate_objective_items = function() {
	var _arr_len = num_of_items_to_get()
	var _p_arr_len = array_length(possible_items)
	global.objective_list = []
	repeat(_arr_len) {
		array_push(global.objective_list, possible_items[irandom(_p_arr_len-1)])
	}
}


