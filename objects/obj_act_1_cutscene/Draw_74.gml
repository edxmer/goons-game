

var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()
if (draw_bg) {
	draw_set_colour(bg_color)
	draw_rectangle(0, 0, gui_w, gui_h, false)
}