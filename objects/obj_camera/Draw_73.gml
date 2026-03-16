/* Drawing the vignette to the edge of the map */


var spr_size = 16

var tlx = global.camera_top_left_x
var tly = global.camera_top_left_y
var brx = global.camera_bot_right_x-spr_size
var bry = global.camera_bot_right_y-spr_size


var spr = spr_vignette

for (var i = tly; i<=bry; i+=spr_size) {
	draw_sprite(spr, 0, tlx, i)
	draw_sprite(spr, 2, brx, i)
}

for (var i = tlx; i<= brx+spr_size; i+= spr_size) {
	draw_sprite(spr, 1, i, bry)
	draw_sprite(spr, 3, i, tly)
}