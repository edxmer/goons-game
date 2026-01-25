

var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()
if (draw_bg) {
	draw_set_colour(bg_color)
	draw_rectangle(0, 0, gui_w, gui_h, false)
}

counter += delta_time*0.00001

if (show_primordial_goo) {
	if (pgoo_alpha < 1 && !goo_fade_back)
		pgoo_alpha += delta_time*0.000001
	if (pgoo_alpha > 0 && goo_fade_back)
		pgoo_alpha -= delta_time*0.000001
		
	var _gx = gui_w/2-110
	var _gy = gui_h/5
	draw_sprite_ext(spr_primordial_goo, 0, _gx, _gy, 3, 3, 0, c_white, pgoo_alpha)
	draw_sprite_ext(spr_halo, 0, _gx+100, _gy+100, 17, 17, counter, c_white, pgoo_alpha)
}

if (show_goon) {
	if (goon_alpha < 1)
		goon_alpha += delta_time*0.000001
	var _gx = gui_w/2
	var _gy = gui_h/3
	draw_sprite_ext(spr_goon, 0, _gx, _gy, 6, 6, 0, c_white, goon_alpha)
	
}