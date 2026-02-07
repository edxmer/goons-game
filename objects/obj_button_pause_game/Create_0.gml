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
	if global.pause_menu
	{
		global.pause_menu=false
	}
	else
	{
		global.pause_menu=true
		instance_create_depth(x,y,depth,obj_pause_menu)
	}
}