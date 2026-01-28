depth=-room_width-20

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

color_dark = make_colour_rgb(43, 103, 151)
color_light = make_colour_rgb(189, 221, 244)



scale_speaker = 0.12
scale_text = 0.2
box_width = 70
box_height = 30
padding = 6
border_size = 1

x = follow_id.x + offset_x
y = follow_id.y + offset_y

top_left_x = x-box_width/2
top_left_y = y-box_height/2
bot_right_x = x+box_width/2
bot_right_y = y+box_height/2