var camera_size=1
with(obj_camera)
{
	camera_size=cam_size
}
var cam=view_get_camera(0)
var x_mid=camera_get_view_x(cam)+(camera_get_view_width(cam)/2)
y=camera_get_view_y(cam)+(camera_get_view_height(cam)/2)
x=x_mid+(reward_no-1)*60