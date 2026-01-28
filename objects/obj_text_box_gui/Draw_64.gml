
draw_set_color(c_black)
draw_rectangle(top_left_x, top_left_y, bot_right_x, bot_right_y, false)

draw_set_color(c_white)
draw_rectangle(top_left_x, top_left_y, bot_right_x, bot_right_y, true)

draw_set_color(c_white)

draw_set_halign(fa_left)
draw_set_valign(fa_top)


// DRAW SPEAKER NAME
draw_set_font(font_speaker)

var _padding_multiplier_head = 0.3
draw_text(top_left_x + padding*_padding_multiplier_head, top_left_y + padding*_padding_multiplier_head, speaker_current)

// DRAW BODY TEXT
draw_set_font(font_body)

var _padding_multiplier_body = 1.5
draw_text_ext(top_left_x + padding*_padding_multiplier_body, top_left_y + padding, text_current, 30, box_width - padding*_padding_multiplier_body*2)

