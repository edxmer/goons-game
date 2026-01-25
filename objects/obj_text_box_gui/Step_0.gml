
var _len = string_length(data[data_id].text)


if (text_at != _len) {
	text_at += text_speed * delta_time * 0.000001
	text_at = clamp(text_at, 1, _len)
}

var text_prev = text_current
text_current = string_replace_all(string_copy(data[data_id].text, 1, floor(text_at)), "§", "")
if (string_length(text_prev) < string_length(text_current))
	sound_play_at(sound_typing, 0, 0)
speaker_current = data[data_id].speaker