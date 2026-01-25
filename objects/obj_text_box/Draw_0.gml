

draw_set_color(c_white)
draw_rectangle(top_left_x-border_size, top_left_y-border_size, bot_right_x+border_size, bot_right_y+border_size, false)

draw_set_color(c_black)
draw_rectangle(top_left_x, top_left_y, bot_right_x, bot_right_y, false)


draw_set_color(c_white)

draw_set_halign(fa_left)
draw_set_valign(fa_top)


// DRAW SPEAKER NAME
draw_set_font(fnt_fancy)
draw_text_transformed(top_left_x + padding*0.2, top_left_y + padding*0.2, speaker_current, scale_speaker, scale_speaker, 0)


// DRAW BODY TEXT
draw_set_font(fnt_body)
draw_text_ext_transformed(top_left_x + padding, top_left_y + padding, text_current, 20, (box_width - padding*2)/scale_text, scale_text, scale_text, 0)

