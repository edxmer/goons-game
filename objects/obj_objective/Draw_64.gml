
var _arr_len = array_length(global.objective_list)

text_scale=1
text_offset_x = -50
text_offset_y = -25
text_rotation = 5
shadow_offset = 2

level_text_scale=0.9
level_text_offset_x = -30
level_text_offset_y = 90
level_text_rotation = -2
level_shadow_offset = 2

// Draw boxes and items
for (var i=0; i<_arr_len; i++) {
	var _x_offset = i*dist_between_items;
	draw_set_color(c_white)
	draw_rectangle(x+_x_offset, y, x+width+_x_offset, y+height, false)

	draw_set_color(c_black)
	draw_rectangle(x+outline+_x_offset, y+outline, x+width-outline+_x_offset, y+height-outline, false)
	
	draw_item(100+_x_offset, 100, global.objective_list[i], 5)
}
// Draw "objectives" text
// DRAW SPEAKER NAME

draw_set_font(fnt_times_italic_bold)
draw_set_color(c_black)
draw_text_transformed(x+text_offset_x+shadow_offset, y+text_offset_y+shadow_offset, "Objectives", text_scale, text_scale, text_rotation)
draw_set_color(c_white)
draw_text_transformed(x+text_offset_x, y+text_offset_y, "Objectives", text_scale, text_scale, text_rotation)

// DRAW LEVEL
level_str = "LEVEL " + string(level)
draw_set_font(fnt_fancy_2)
draw_set_color(c_black)
draw_text_transformed(x+level_text_offset_x+level_shadow_offset, y+level_text_offset_y-level_shadow_offset, level_str, level_text_scale, level_text_scale, level_text_rotation)
draw_set_color(c_white)
draw_text_transformed(x+level_text_offset_x, y+level_text_offset_y, level_str, level_text_scale, level_text_scale, level_text_rotation)
