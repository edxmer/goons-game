
var _spr_width = sprite_get_width(box_sprite)
var _spr_height = sprite_get_height(box_sprite)

draw_sprite_ext(box_sprite, 0, top_left_x, top_left_y, box_size, box_size, 0, c_white, 1)

//draw_set_color(c_black)
//draw_rectangle(top_left_x, top_left_y, bot_right_x, bot_right_y, false)

//draw_set_color(c_white)
//draw_rectangle(top_left_x, top_left_y, bot_right_x, bot_right_y, true)

draw_set_color(c_black)




// DRAW SPEAKER NAME
draw_set_font(font_speaker)


var _extra_padding = 50
var _text_top_left_x = top_left_x + _extra_padding
var _text_top_left_y = top_left_y + _extra_padding


var _padding_multiplier_head = 0.3
draw_text(_text_top_left_x + padding*_padding_multiplier_head, 
			_text_top_left_y + padding*_padding_multiplier_head, 
			speaker_current)

// DRAW BODY TEXT
draw_set_font(font_body)

var _padding_multiplier_body = 1.5
draw_text_ext(_text_top_left_x + padding*_padding_multiplier_body,
				_text_top_left_y + padding, text_current, 30, 
				_spr_width*box_size - padding*_padding_multiplier_body*2 - _extra_padding * 2)

