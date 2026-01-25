
var _arr_len = array_length(data)
var _len = string_length(data[data_id].text)
	
if (text_at < _len) {
	// IN THE MIDDLE OF SPEECH
	// skip to end
	text_at = _len
}
else {
	// AT END OF SPEECH
	// skip to next, and do the action
	
	data[data_id].action()
	text_current = ""
	speaker_current = ""
	text_at = 0
	data_id++
	if (data_id >= _arr_len) {
		global.text_box_gui_active = false
		instance_destroy(self)
	}
}