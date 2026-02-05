// Inherit the parent event
event_inherited();

button_text = "select all goons"
button_size = 4
button_sprite = spr_button_2
button_sprite_index = 0

text_size = .75
text_font = fnt_body

var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

x = _guiw - 110
y = 125

on_press = function() {
	var _gooned = 0
	var already_gooned=0
	
	with (obj_goon) {
		if gooning{
			already_gooned++
		}
		else{
			sound_play_category_at("murr",id.x,id.y)
			gooning=true
			_gooned++
		}
	}
	if already_gooned==global.goon_count
	{
		with (obj_goon)
		{
			gooning=false
		}
	}
	
	with obj_cursor {
		goons_selected = _gooned
	}
}