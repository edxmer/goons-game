//var _hovering = position_meeting(mouse_x, mouse_y, id)
//var _hovering = position_meeting


var _prev_hovering = hovering

var _mx = device_mouse_x_to_gui(0)
var _my = device_mouse_y_to_gui(0)

var _btnx = x - sprite_get_width(button_sprite)*button_size/2
var _btny = y - sprite_get_height(button_sprite)*button_size/2
var _width = sprite_get_width(button_sprite) * button_size
var _height = sprite_get_height(button_sprite) * button_size


hovering = point_in_rectangle(_mx, _my, _btnx, _btny, _btnx+_width, _btny+_height)
if (hovering != _prev_hovering) {
	global.is_hovering_gui = hovering
}


if (hovering) {
	if (button_sprite_index == 0)
		sound_play_category_at("swoosh", 0, 0)
	button_sprite_index = 1
} else {
	button_sprite_index = 0
}