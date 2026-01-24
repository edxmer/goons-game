var cam=view_get_camera(0)
var cam_old_x=camera_get_view_x(cam)
var cam_old_y=camera_get_view_y(cam)
var cam_x_size=camera_get_view_width(cam)
var cam_y_size=camera_get_view_height(cam)

var move_y=keyboard_check(ord("S"))-keyboard_check(ord("W"))
var move_x=keyboard_check(ord("D"))-keyboard_check(ord("A"))
x+=move_x*camera_speed
y+=move_y*camera_speed

x=clamp(x,0,room_width-cam_x_size)
y=clamp(y,0,room_height-cam_y_size)
var cam_x=x
var cam_y=y
//camera_set_view_pos(cam,global.player.coordinates[0],global.player.coordinates[1])
global.cam.coords=[cam_x,cam_y]
global.cam.coords_middle=[cam_x+cam_x_size/2,cam_y+cam_y_size/2]
global.cam.coords_bottom=[cam_x+cam_x_size,cam_y+cam_y_size]
camera_set_view_pos(cam,cam_x,cam_y)

if keyboard_check_pressed(vk_f11){
window_set_fullscreen(!window_get_fullscreen());
}