// Changeable variables
speaker_name = "Larry"
texts = [
	"Hello there, I'm Larry.",
	"Larry larry larry larry larry larry larry larry larry larry larry larry larry",
	"Larry larry larry."
]
text_speed = 15


// yo chocolate ice cream with chicken soup


// Private variables
text_current = ""
text_at = 0
text_id = 0


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
