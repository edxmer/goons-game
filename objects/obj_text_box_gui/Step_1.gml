
var _mx = device_mouse_x_to_gui(0)
var _my = device_mouse_y_to_gui(0)

var _btnx = x - sprite_get_width(box_sprite)*box_size/2
var _btny = y - sprite_get_height(box_sprite)*box_size/2
var _width = sprite_get_width(box_sprite) * box_size
var _height = sprite_get_height(box_sprite) * box_size


hovering = point_in_rectangle(_mx, _my, _btnx, _btny, _btnx+_width, _btny+_height)

var _hoverng_arr_ind = array_get_index(global.gui_hovering, self)

if (hovering) {
	if (_hoverng_arr_ind == -1) {
		array_push(global.gui_hovering, self)
	}
	
} else {
	if (_hoverng_arr_ind != -1) {
		array_delete(global.gui_hovering, _hoverng_arr_ind, 1)
	}
}