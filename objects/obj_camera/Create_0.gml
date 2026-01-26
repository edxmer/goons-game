

gpu_set_texfilter(false);
var cam=view_get_camera(0)
width_base=camera_get_view_width(cam)
height_base=camera_get_view_height(cam)
camera_size=1.6
x=(room_width>>1)-(width_base*0.5*camera_size)
y=(room_height>>1)-(height_base*0.5)
camera_speed=3


	camera_set_view_size(cam,width_base*camera_size,height_base*camera_size)

mouse_go_percent=0.2