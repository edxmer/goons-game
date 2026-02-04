// Inherit the parent event
event_inherited();

button_text = "edit goon"
button_size = 4
button_sprite = spr_button_2
button_sprite_index = 0

text_size = .8
text_font = fnt_body

var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

x = _guiw - 110
y = 205

on_press = function() {
	if global.last_selected_goon!=noone && instance_exists(global.last_selected_goon)
	{
		if global.goon_edit_id!=global.last_selected_goon
		{
			edit_goon(global.last_selected_goon)
		}
		else
		{
			exit_goon_edit_mode()
		}
	}
}