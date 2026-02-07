// Inherit the parent event
event_inherited();

button_text = "reset zoom"
button_size = 4
button_sprite = spr_button_2
button_sprite_index = 0

text_size = .8
text_font = fnt_body

var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

x = _guiw - 110
y = 285

on_press = function() {
	with(obj_camera)
	{
		zoom_to_back=global.default_camera_size
		real_x=global.cam.coords[0]+(width_base*global.camera_size-width_base*global.default_camera_size)*0.66
		real_y=global.cam.coords[1]+(height_base*global.camera_size-height_base*global.default_camera_size)*0.66
	}
}