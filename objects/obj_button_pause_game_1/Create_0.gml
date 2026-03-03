// Inherit the parent event
event_inherited();

button_text = "pause game"
button_size = 4
button_sprite = spr_button_2
button_sprite_index = 0

text_size = .8
text_font = fnt_body

var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

x = _guiw - 110
y = 45

on_press = function() {
	room_persistent = true
	global.pause_sprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
	room_goto(room_pause_menu)
}