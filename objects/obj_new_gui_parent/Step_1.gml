if assigned_y==0
{
	assigned_y=calc_real_y(priority)
}

show_y=show_y*0.4+0.6*real_y

on_mouse=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),real_x-11*size,real_y-11*size,real_x+11*size,real_y+11*size)
on_arrows=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),real_x-11*size,real_y-11*size,real_x+20*size,real_y+11*size)
on_up=on_arrows&&(!on_mouse)&& device_mouse_y_to_gui(0)<=real_y && can_switch_this_turn
on_down=(!on_mouse)&&(!on_up) && can_switch_this_turn

if on_arrows && !on_mouse
{
	if mouse_check_button_pressed(mb_left)
	{
		var ex_lower=false
		var ex_higher=false
		with(obj_new_gui_parent)
		{
			if other.priority>priority
			{
				ex_lower=true
			}
			if other.priority<priority
			{
				ex_higher=true
			}
		}
		var reset=false
		if on_down && ex_higher
		{
			reset=true
			with(obj_new_gui_parent)
			{
				if priority-1==other.priority
				{
					priority--
				}
			}
			priority++
		}
		else if on_up && ex_lower
		{
			reset=true
			with(obj_new_gui_parent)
			{
				if priority+1==other.priority
				{
					priority++
				}
			}
			priority--
		}
		if reset{
			
			breset()
		}
	}
}


if on_mouse && mouse_check_button_pressed(mb_left)
{
	sound_play_category_at("click",global.cam.coords_middle[0],global.cam.coords_middle[1])
	show_y+=2*size
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
	if signs_size_mult<1
	{
		signs_size_mult=clamp(signs_size_mult+0.2,0,1)
	}
	
	update_opened()
	var yy=real_y+18*size
	sign_selected=-1
	
	
	
	for (var i=0;i<array_length(signs);i++)
	{
		var signd=signs[i]
		var xx_start=real_x-29*size
		var xx_end=real_x+11*size
		if signd.small 
		{
			xx_end=real_x-8*size
		}
		
		
		if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),xx_start,yy-6*size+1,xx_end,yy+6*size)
		{
			sign_selected=i
			break
		}
		yy+=sign_size*size
	}
}
else
{
	signs_size_mult=0.2
	sign_selected=-1
}

if sign_selected!=-1 && mouse_check_button_pressed(mb_left)
{
	sound_play_category_at("click",global.cam.coords_middle[0],global.cam.coords_middle[1])
	button_clicked()
	add_ind()
	global.is_hovering_gui=true

}



var _hoverng_arr_ind = array_get_index(global.gui_hovering, id)
if hov_gui_check()
{

		if (button_sprite_index == 0)
			sound_play_category_at("swoosh", 0, 0)
		button_sprite_index = 1
	
		if (_hoverng_arr_ind == -1) {
			add_ind()
		}
	
	
}
else {
		button_sprite_index = 0
		if (_hoverng_arr_ind != -1) {
			array_delete(global.gui_hovering, _hoverng_arr_ind, 1)

		}
}
	