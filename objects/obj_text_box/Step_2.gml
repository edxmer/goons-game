if !instance_exists(follow_id) {
	instance_destroy()
	exit
}

if (array_length(data) == 0) {
    exit;
}


x = follow_id.x + offset_x
y = follow_id.y + offset_y

top_left_x = x-box_width/2
top_left_y = y-box_height/2
bot_right_x = x+box_width/2
bot_right_y = y+box_height/2


if (data_id >= array_length(data)) {
    instance_destroy();
    exit;
}

var _len = string_length(data[data_id].text)
var _arr_len = array_length(data)

var _t = get_timer() * 0.001 // how long the game has been running, in miliseconds

text_current = string_replace_all(string_copy(data[data_id].text, 1, floor(text_at)), "§", "")
speaker_current = data[data_id].speaker

if (text_at < _len) {
	text_at += text_speed * delta_time * 0.000001
	text_at = clamp(text_at, 1, _len)
} else {
	if (!waiting) {
		waiting = true
		timer_start = _t
	} else if (timer_start + data[data_id].lifetime < _t) {
		waiting = false
		data[data_id].action()
		
		text_current = ""
		speaker_current = ""
		text_at = 0
		data_id++
		if (data_id >= _arr_len)
			instance_destroy(self)
	}
	
}