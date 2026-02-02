var cam=view_get_camera(0)

var cam_old_x=camera_get_view_x(cam)
var cam_old_y=camera_get_view_y(cam)
var cam_x_size=camera_get_view_width(cam)
var cam_y_size=camera_get_view_height(cam)

var width=camera_get_view_width(cam)
var height=camera_get_view_height(cam)

var move_x = 0
var move_y = 0


// MOVEMENT
if (pressing_right) {
    
	var multiplier = 0.33 * (1/global.camera_size)
	
	move_x = multiplier * (prev_x - mouse_x)
	move_y = multiplier * (prev_y - mouse_y)
}

var x_go=move_x*camera_speed*global.camera_size
var y_go=move_y*camera_speed*global.camera_size


// RESIZING
if mouse_wheel_down(){
	var old_size=global.camera_size
	global.camera_size+=0.2
	
	var x_zoom=clamp((mouse_x-x)/width,0,1)
	var y_zoom=clamp((mouse_y-y)/height,0,1)
	
	if global.camera_size<=3{
		x+=x_zoom*width_base*old_size-x_zoom*width_base*global.camera_size
		y+=y_zoom*height_base*old_size-y_zoom*height_base*global.camera_size
		reset_smoothness()
	}
	global.camera_size=clamp(global.camera_size,0.4,3)
	camera_set_view_size(cam,width_base*global.camera_size,height_base*global.camera_size)
}

else if mouse_wheel_up(){
	var width=camera_get_view_width(cam)
	var height=camera_get_view_height(cam)
	var old_size=global.camera_size
	global.camera_size-=0.2
	
	var x_zoom=clamp((mouse_x-x)/width,0,1)
	var y_zoom=clamp((mouse_y-y)/height,0,1)
	
	//
	if global.camera_size>=0.4{
		x+=x_zoom*width_base*old_size-x_zoom*width_base*global.camera_size
		y+=y_zoom*height_base*old_size-y_zoom*height_base*global.camera_size
		reset_smoothness()
	}
	global.camera_size=clamp(global.camera_size,0.5,3)
	camera_set_view_size(cam,width_base*global.camera_size,height_base*global.camera_size)
}




real_x+=x_go//move_x*camera_speed*global.camera_size
real_y+=y_go//move_y*camera_speed*global.camera_size
real_x=clamp(real_x,0,room_width-cam_x_size)
real_y=clamp(real_y,0,room_height-cam_y_size)
x+=(real_x-x)/2
y+=(real_y-y)/2
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




prev_x = mouse_x
prev_y = mouse_y