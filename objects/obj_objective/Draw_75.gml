depth=-room_height*3
draw_calories_meter(x, y, 120, size)


draw_set_font(font)
draw_set_color(c_black)
draw_text_transformed(x+text_offset_x+shadow_offset, y+text_offset_y+shadow_offset,title_text, text_scale*size, text_scale*size, text_rotation)
draw_set_color(c_white)
draw_text_transformed(x+text_offset_x, y+text_offset_y, title_text, text_scale*size, text_scale*size, text_rotation)

// DRAW LEVEL
level_str = "level " + string(level)
draw_set_font(fnt_header_1)
draw_set_color(c_black)
draw_text_transformed(x+level_text_offset_x+level_shadow_offset_x, y+level_text_offset_y-level_shadow_offset_y, level_str, level_text_scale*size, level_text_scale*size, level_text_rotation)
draw_set_color(c_white)
draw_text_transformed(x+level_text_offset_x, y+level_text_offset_y, level_str, level_text_scale*size, level_text_scale*size, level_text_rotation)

