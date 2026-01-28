depth=-room_height-bbox_bottom

data = []
follow_id = self
offset_x = 0
offset_y = 0


data_id = 0
text_current = ""
speaker_current = ""
text_at = 0
text_speed = 15

waiting = false
timer_start = 0

color_dark = #101119 //make_colour_rgb(43, 103, 151)
color_light =#E0D6BC //make_colour_rgb(189, 221, 244)



scale_speaker = 0.14
scale_text = 0.25
box_width = 90
box_height = 50
padding = 6
border_size = 1

x = follow_id.x + offset_x
y = follow_id.y + offset_y