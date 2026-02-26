exit
var _arr_len = array_length(global.objective_list)




// Draw calorie meter
var _fullness = global.current_calories / global.needed_calories




// Draw boxes and items
for (var i=0; i<_arr_len; i++) {
	var _x_offset = i*dist_between_items
	
	var _sprite_x = x+_x_offset+50
	var _sprite_y = y+58
	draw_sprite_ext(spr_outline, 3,_sprite_x, _sprite_y, 4.5, 4.5, 0, c_white, 1)
	/*
	draw_set_color(c_white)
	draw_rectangle(x+_x_offset, y, x+width+_x_offset, y+height, false)

	draw_set_color(c_black)
	draw_rectangle(x+outline+_x_offset, y+outline, x+width-outline+_x_offset, y+height-outline, false)
	*/
	
	draw_item(100+_x_offset, 100, global.objective_list[i], 5)
}
// Draw "objectives" text
// DRAW SPEAKER NAME


