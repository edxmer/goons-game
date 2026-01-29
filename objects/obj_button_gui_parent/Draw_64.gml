
draw_set_halign(fa_center)
draw_set_valign(fa_middle)

draw_sprite_ext(button_sprite, button_sprite_index, x, y, button_size, button_size, 0, c_white, 1)

draw_set_font(text_font)
draw_set_colour(c_black)

draw_text_transformed(x, y, button_text, text_size, text_size, 0)

draw_set_halign(fa_left)
draw_set_valign(fa_top)