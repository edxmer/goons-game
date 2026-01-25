var camera_size=1
with(obj_camera)
{
	camera_size=cam_size
}
var cam=view_get_camera(0)
var x_mid=camera_get_view_x(cam)+(camera_get_view_width(cam)/2)
y=camera_get_view_y(cam)+(camera_get_view_height(cam)/2)
x=x_mid+(reward_no-1)*40*camera_size
image_xscale=camera_size
image_yscale=camera_size

if point_in_rectangle(mouse_x,mouse_y,x-16*camera_size,y-16*camera_size,x+16*camera_size,y+16*camera_size)
{
	image_xscale*=1.2
	image_yscale*=1.2
	if !selected
	{
		selected=true
		sound_play_category_at("swoosh",x,y)
	}
}
else if selected
{
	selected=false
	sound_play_category_at("swoosh",x,y)

}


if selected && mouse_check_button_pressed(mb_left) && global.reward_mode
{
	if type=="workstation"{
		
	}
}