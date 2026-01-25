x = 50
y = 40


height = 110
width = 100
// temporary
outline = 1
draw_set_color(c_white)
draw_rectangle(x, y, x+width, y+height, false)

draw_set_color(c_black)
draw_rectangle(x+outline, y+outline, x+width-outline, y+height-outline, false)


draw_item(100, 100, "logs", 5)