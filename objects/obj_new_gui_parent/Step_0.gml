if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),real_x-11*size,real_y-11*size,real_x+11*size,real_y+11*size)
{
	on_mouse=true

}
if mouse_check_button_pressed(mb_left)
{
	sound_play_category_at("click",global.cam.coords_middle[0],global.cam.coords_middle[1])
	if active
	{
		close_up()
	}
	if !active
	{
		open_up()
	}
}

if active
{
	update_opened()
	var yy=real_y+16*size
	sign_selected=-1
	for (var i=0;i<array_length(signs);i++)
	{
		if on_mouse
		{
			break
		}
		if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),real_x-11*size,real_y-5*size,real_x+11*size,real_y+11*size)
		{
			sign_selected=i
			break
		}
		yy+=10*size
	}
}
else
{
	sign_selected=-1
}