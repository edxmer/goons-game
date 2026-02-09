draw_set_font(title_font)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)


var _gui_w = display_get_gui_width()
var _gui_h = display_get_gui_height()

var _x = _gui_w/2
var _y = _gui_h/6

// outline
draw_set_colour(#333333)
draw_text_transformed_colour(_x + outline, _y + outline, text, scale, scale, 0, c_white, c_red, c_blue, c_orange, 0.5)


draw_set_colour(c_white)
draw_text_transformed(_x, _y, text, scale, scale, 0)