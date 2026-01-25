x=room_width>>1
y=room_height>>1

gpu_set_texfilter(false);
var cam=view_get_camera(0)
width_base=camera_get_view_width(cam)
height_base=camera_get_view_height(cam)
camera_speed=3

camera_size=1.6
	camera_set_view_size(cam,width_base*camera_size,height_base*camera_size)

mouse_go_percent=0.25