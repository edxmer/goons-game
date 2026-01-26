

draw_set_font(fnt_fancy_2)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)


var _gui_w = display_get_gui_width()
var _gui_h = display_get_gui_height()

// outline
draw_set_colour(c_white)
draw_text_transformed(_gui_w/2+outline, _gui_h/4+outline, text, scale, scale, 0)
draw_text_transformed(_gui_w/2+outline, _gui_h/4-outline, text, scale, scale, 0)
draw_text_transformed(_gui_w/2-outline, _gui_h/4+outline, text, scale, scale, 0)
draw_text_transformed(_gui_w/2-outline, _gui_h/4-outline, text, scale, scale, 0)


draw_set_colour(c_black)
draw_text_transformed(_gui_w/2, _gui_h/4, text, scale, scale, 0)