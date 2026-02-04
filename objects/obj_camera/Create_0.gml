var heightmax=room_height
if variable_global_exists("room_height")
{
heightmax=global.room_height
}

gpu_set_texfilter(false);
var cam=view_get_camera(0)
width_base=camera_get_view_width(cam)
height_base=camera_get_view_height(cam)
global.default_camera_size = 1.6
global.camera_size=global.default_camera_size
x=(room_width>>1)-(width_base*0.5*global.camera_size)
y=(heightmax>>1)-(height_base*0.5)
camera_speed=3

real_x=x
real_y=y

zoom_to_back=global.camera_size

was_special_mode=false
bef_special_x=x
bef_special_y=x

	camera_set_view_size(cam,width_base*global.camera_size,height_base*global.camera_size)

mouse_go_percent=0//0.15

reset_smoothness=function(_x=x,_y=y)
{
real_x=_x
real_y=_y
}

global.is_hovering_gui = false // valamiért nem működnik ha csak a global_variables-ben van


prev_x = x
prev_y = y
pressing_right = false

was_zoom=global.default_camera_size

zoom_from=function(from_x,from_y,old_size)
{
	var cam=view_get_camera(0)
	var width=camera_get_view_width(cam)
	var height=camera_get_view_height(cam)
	var x_zoom=clamp((from_x-x)/width,0,1)
	var y_zoom=clamp((from_y-y)/height,0,1)
	
	//
	if global.camera_size>=0.5 &&global.camera_size<=3{
		global.camera_size=clamp(global.camera_size,0.5,3)
		x+=x_zoom*width_base*old_size-x_zoom*width_base*global.camera_size
		y+=y_zoom*height_base*old_size-y_zoom*height_base*global.camera_size
		if (! global.special_mode) && zoom_to_back==global.camera_size &&bef_special_x==real_x &&bef_special_y=real_y
		{
			reset_smoothness(x,y)
		}
		
		
	}
	global.camera_size=clamp(global.camera_size,0.5,3)
	camera_set_view_size(cam,width_base*global.camera_size,height_base*global.camera_size)


}