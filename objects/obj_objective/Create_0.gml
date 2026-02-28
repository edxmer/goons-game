
level = global.reward_level

title_text = "Nutritional values"



previous_level = 1

second_happened=false

currently_held_items = []

possible_items = []
first_end_step = false


font = fnt_header_1
x = 80
y = 80
height = 110
width = 120
outline = 5
dist_between_items = width-outline

size = 5

text_offset_x = -50
text_offset_y = -60
level_text_offset_x = -40
level_text_offset_y = 10
text_scale=0.24

level_shadow_offset_x = 3
level_shadow_offset_y = -3
shadow_offset = 3




num_of_items_to_get = function(){
	return floor(log2(level+1))+1
}

generate_objective_items = function() {
	possible_items = workstation_get_all_possible_items()
	var _arr_len = num_of_items_to_get()
	var _p_arr_len = array_length(possible_items)
	array_push(global.objective_list,"craft")
	global.objective_list = []
	array_push(global.objective_list,"craft")
	repeat(_arr_len-1) {
		//array_push(global.objective_list, possible_items[irandom(_p_arr_len-1)])
		array_push(global.objective_list,"any")
	}
	global.objective_list=transform_objective_list(global.objective_list)
}





text_rotation = 2
text_pulse_timer=0



level_text_rotation = -5

