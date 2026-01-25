
var _arr_len = array_length(texts)
var _len = string_length(texts[text_id])
	
if (text_at < _len) {
	// IN THE MIDDLE OF SPEECH
	// skip to end
	text_at = _len
}
else {
	// AT END OF SPEECH
	// skip to next
	text_current = ""
	text_at = 0
	text_id++ 
	if (text_id == _arr_len)
		instance_destroy(self)
}