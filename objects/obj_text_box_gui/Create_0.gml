

data = []

data_id = 0
text_current = ""
speaker_current = ""
text_at = 0
text_speed = 15

hovering = false

font_body = fnt_body
font_speaker = fnt_header_2

box_size = 5
autoskip=false

box_sprite = spr_speech_box_gui
var _spr_width = sprite_get_width(spr_speech_box_gui)
var _spr_height = sprite_get_height(spr_speech_box_gui)

if (!variable_global_exists("gui_hovering"))
	global.gui_hovering = []


padding = 30
var guiW = display_get_gui_width()
var guiH = display_get_gui_height()
self.x = guiW/2
self.y = guiH/5*4



original_master_gain = -1
// SKIP BUTTON
skip_btn_id = instance_create_depth(x, y, -50, obj_button_gui_parent)
skip_btn_id.x = x+box_size*_spr_width/2-120
skip_btn_id.y = y+box_size*_spr_height/2-60
with (skip_btn_id) {
	button_text = "skip all"
	button_size = 2
	button_sprite = spr_button_2
	button_sprite_index = 0

	text_size = .6
	text_font = fnt_body

	var _guiw = display_get_gui_width()
	var _guih = display_get_gui_height()
}
skip_btn_id.on_press = function() {
	/*for (var i=data_id; i<array_length(data); i++) {
		data[i].action()
	}*/
	
	autoskip=true
	text_speed = 450
	if (original_master_gain = -1) {
		original_master_gain = audio_get_master_gain(0)
		audio_master_gain(original_master_gain/4)
	}
}


top_left_x = x-box_size*_spr_width/2
top_left_y = y-box_size*_spr_height/2
