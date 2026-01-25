
var _len = string_length(texts[text_id])


if (text_at != _len) {
	text_at += text_speed * delta_time * 0.000001
	text_at = clamp(text_at, 1, _len)
}


text_current = string_copy(texts[text_id], 1, floor(text_at))