var _hovering = position_meeting(mouse_x, mouse_y, id)

if (_hovering) {
	image_index = 1
	window_set_cursor(cr_handpoint)
} else {
	image_index = 0
	window_set_cursor(cr_default)
}