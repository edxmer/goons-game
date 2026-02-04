depth=-room_height-bbox_bottom
alpha=1
data = []
follow_id = self
offset_x = 0
offset_y = 0

font_speaker = fnt_header_3
font_body = fnt_body

data_id = 0
text_current = ""
speaker_current = ""
text_at = 0
text_speed = 15

waiting = false
timer_start = 0

color_dark = #101119 //make_colour_rgb(43, 103, 151)
color_light =#E0D6BC //make_colour_rgb(189, 221, 244)



scale_speaker = 0.13
scale_text = 0.2
box_width = 55
box_height = 35
padding = 4
border_size = 1

x = follow_id.x + offset_x
y = follow_id.y + offset_y