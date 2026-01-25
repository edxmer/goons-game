
global.text_box_gui_active = true

data = []

data_id = 0
text_current = ""
speaker_current = ""
text_at = 0
text_speed = 15



box_width = 500
box_height = 200
padding = 30
var guiW = display_get_gui_width()
var guiH = display_get_gui_height()
self.x = guiW/2
self.y = guiH/4*3

top_left_x = x-box_width/2
top_left_y = y-box_height/2
bot_right_x = x+box_width/2
bot_right_y = y+box_height/2
