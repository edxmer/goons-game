if assigned_y==0
{
	assigned_y=real_y
}

on_mouse=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),real_x-11*size,real_y-11*size,real_x+11*size,real_y+11*size)



if on_mouse && mouse_check_button_pressed(mb_left)
{
	sound_play_category_at("click",global.cam.coords_middle[0],global.cam.coords_middle[1])
	if active
	{
		close_up()
	}
	else
	{
		calculate_sign_size()
		open_up()
	}
}

if active
{
	update_opened()
	var yy=real_y+20*size
	sign_selected=-1
	for (var i=0;i<array_length(signs);i++)
	{
	
		if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),real_x-11*size,yy-5*size,real_x+11*size,yy+5*size)
		{
			sign_selected=i
			break
		}
		yy+=sign_size*size
	}
}
else
{
	sign_selected=-1
}

if sign_selected!=-1 && mouse_check_button_pressed(mb_left)
{
	sound_play_category_at("click",global.cam.coords_middle[0],global.cam.coords_middle[1])
	button_clicked()

}



var _hoverng_arr_ind = array_get_index(global.gui_hovering, id)
if on_mouse || sign_selected!=-1
{

		if (button_sprite_index == 0)
			sound_play_category_at("swoosh", 0, 0)
		button_sprite_index = 1
	
		if (_hoverng_arr_ind == -1) {
			array_push(global.gui_hovering, id)
		}
	
	
}
else {
		button_sprite_index = 0
		if (_hoverng_arr_ind != -1) {
			array_delete(global.gui_hovering, _hoverng_arr_ind, 1)

		}
}
	