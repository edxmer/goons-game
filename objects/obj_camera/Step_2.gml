var cam=view_get_camera(0)

var cam_old_x=camera_get_view_x(cam)
var cam_old_y=camera_get_view_y(cam)
var cam_x_size=camera_get_view_width(cam)
var cam_y_size=camera_get_view_height(cam)

var width=camera_get_view_width(cam)
var height=camera_get_view_height(cam)

var move_x = 0
var move_y = 0

var x_go=0
var y_go=0

// MOVEMENT
if global.special_mode
{
	if global.goon_edit_mode
	{
		real_x=global.special_coords[0]-(global.cam.coords_middle[0]-global.cam.coords[0])/global.camera_size
		real_y=global.special_coords[1]-(global.cam.coords_middle[1]-global.cam.coords[1])/global.camera_size
	}
	if !was_special_mode
	{
		bef_special_x=real_x
		bef_special_y=real_y
		if global.reward_mode{
			real_x=global.special_coords[0]-(global.cam.coords_middle[0]-global.cam.coords[0])/global.camera_size
			real_y=global.special_coords[1]+20-(global.cam.coords_middle[1]-global.cam.coords[1])/global.camera_size
		}
	}
	if global.camera_size>1
	{
		var old_size=global.camera_size
		global.camera_size-=0.2
	

	
		zoom_from(global.cam.coords_middle[0],global.cam.coords_middle[1],old_size)
	}
}
else
{
	if (pressing_right) {
    
		var multiplier = 0.33 * (1/global.camera_size)
	
		move_x = multiplier * (prev_x - mouse_x)
		move_y = multiplier * (prev_y - mouse_y)
	}
	else
	{
		move_x=keyboard_check(ord("D"))-keyboard_check(ord("A"))
		move_y=keyboard_check(ord("S"))-keyboard_check(ord("W"))
	}
	if was_special_mode
	{
		real_x=bef_special_x
		real_y=bef_special_y
	}

	x_go=move_x*camera_speed*global.camera_size
	y_go=move_y*camera_speed*global.camera_size


// RESIZING


	if mouse_wheel_down(){
		var old_size=global.camera_size
		global.camera_size+=0.2
	

		zoom_to_back=global.camera_size
	
		zoom_from(mouse_x,mouse_y,old_size)
	}

	else if mouse_wheel_up(){

		var old_size=global.camera_size
		global.camera_size-=0.2
	
		zoom_to_back=global.camera_size
		zoom_from(mouse_x,mouse_y,old_size)
	}
	else if !global.special_mode && zoom_to_back!=global.camera_size
	{
		var old_size=global.camera_size
		var difference= zoom_to_back-global.camera_size

		global.camera_size+=clamp(difference,-0.2,0.2)
		if abs(difference)<0.2
		{
			zoom_to_back=global.camera_size
		}
		zoom_from(global.cam.coords_middle[0],global.cam.coords_middle[1],old_size)

	}
}




real_x+=x_go//move_x*camera_speed*global.camera_size
real_y+=y_go//move_y*camera_speed*global.camera_size
real_x=clamp(real_x,0,room_width-cam_x_size)
real_y=clamp(real_y,0,global.camera_room_height-cam_y_size)
x+=(real_x-x)/2
y+=(real_y-y)/2
x=clamp(x,0,room_width-cam_x_size)
y=clamp(y,0,global.camera_room_height-cam_y_size)
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

was_special_mode=global.special_mode