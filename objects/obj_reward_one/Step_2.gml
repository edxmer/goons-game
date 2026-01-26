var _camera_size=1
with(obj_camera)
{
	_camera_size=camera_size
}
var cam=view_get_camera(0)
var x_mid=camera_get_view_x(cam)+(camera_get_view_width(cam)/2)
y=camera_get_view_y(cam)+(camera_get_view_height(cam)/2)
x=x_mid+(reward_no-1)*40*_camera_size
image_xscale=_camera_size
image_yscale=_camera_size

if point_in_rectangle(mouse_x,mouse_y,x-16*_camera_size,y-16*_camera_size,x+16*_camera_size,y+16*_camera_size)
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
	global.reward_mode=false
	if type=="workstation"{
		sound_play_category_at("woodwork",x,y)
		workstation_scatter(reward_id)
	}
	else if type=="item"
	{
		create_item(room_width>>1,(room_height>>1)+40,reward_id)
		sound_play_category_at("groundsoft",room_width>>1,(room_height>>1)+40)
	}
}