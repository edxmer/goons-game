

gpu_set_texfilter(false);
var cam=view_get_camera(0)
width_base=camera_get_view_width(cam)
height_base=camera_get_view_height(cam)
global.default_camera_size = 1.6
global.camera_size=global.default_camera_size
x=(room_width>>1)-(width_base*0.5*global.camera_size)
y=(room_height>>1)-(height_base*0.5)
camera_speed=3

real_x=x
real_y=y

	camera_set_view_size(cam,width_base*global.camera_size,height_base*global.camera_size)

mouse_go_percent=0.15

reset_smoothness=function()
{
real_x=x
real_y=y
}

global.is_hovering_gui = false // valamiért nem működnik ha csak a global_variables-ben van