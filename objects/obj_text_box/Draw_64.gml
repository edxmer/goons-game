
draw_set_color(c_black)
draw_rectangle(top_left_x, top_left_y, bot_right_x, bot_right_y, false)

draw_set_color(c_white)
draw_rectangle(top_left_x, top_left_y, bot_right_x, bot_right_y, true)

draw_set_color(c_white)

draw_set_halign(fa_left)
draw_set_valign(fa_top)


// DRAW SPEAKER NAME
draw_set_font(fnt_fancy)
draw_text(top_left_x + padding*0.3, top_left_y + padding*0.3, speaker_name)

// DRAW BODY TEXT
draw_set_font(fnt_body)
draw_text_ext(top_left_x + padding*1.5, top_left_y + padding, text_current, 20, box_width - padding*2)