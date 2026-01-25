depth=-room_width-20

data = []
follow_id = self
offset_x = 0
offset_y = 0
scale_speaker = 0.08
scale_text = 0.12

data_id = 0
text_current = ""
speaker_current = ""
text_at = 0
text_speed = 15

waiting = false
timer_start = 0


box_width = 40
box_height = 15
padding = 4
border_size = 1

x = follow_id.x + offset_x
y = follow_id.y + offset_y

top_left_x = x-box_width/2
top_left_y = y-box_height/2
bot_right_x = x+box_width/2
bot_right_y = y+box_height/2