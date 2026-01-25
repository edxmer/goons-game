
var _len = string_length(text)

text_at += text_speed * delta_time * 0.000001
text_at = clamp(text_at, 1, _len)

text_current = string_copy(text, 1, floor(text_at))