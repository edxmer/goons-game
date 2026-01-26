var _hovering = position_meeting(mouse_x, mouse_y, id)

if (_hovering) {
	if (image_index == 0)
		sound_play_category_at("swoosh", 0, 0)
	image_index = 1
} else {
	image_index = 0
}