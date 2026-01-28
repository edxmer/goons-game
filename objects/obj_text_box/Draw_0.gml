
/*
draw_set_color(color_dark)
draw_rectangle(top_left_x-border_size, top_left_y-border_size, bot_right_x+border_size, bot_right_y+border_size, false)

draw_set_color(color_light)
draw_rectangle(top_left_x, top_left_y, bot_right_x, bot_right_y, false)
*/

//draw_set_halign(fa_center)
//draw_set_valign(fa_middle)

var _x = x + offset_x
var _y = y + offset_y

draw_sprite_ext(spr_goon_speech_box, 0, _x, _y, 1.5, 1.5, 0, c_white, 1)

draw_set_color(color_dark)

draw_set_halign(fa_left)
draw_set_valign(fa_top)



var _txt_offset = 8

// DRAW SPEAKER NAME
draw_set_font(font_speaker)
draw_text_transformed(_x + _txt_offset + padding*0.2, _y + _txt_offset, speaker_current, scale_speaker, scale_speaker, 0)


// DRAW BODY TEXT
draw_set_font(font_body)

draw_text_ext_transformed(_x + _txt_offset + padding*0.5, _y + _txt_offset + padding, text_current, 20, (box_width-padding)/scale_text, scale_text, scale_text, 0)

