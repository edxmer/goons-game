// Inherit the parent event

if active
{
	signs=[select_all,select_nearest,unselect_nearest,unselect_all,reset_zoom]
	if show_options
	{
		signs=[select_all,select_nearest,unselect_nearest,unselect_all,option_normal_sign,option_blue_sign,option_dumb_sign,option_no_equip_sign,option_empty_sign,reset_zoom]
	}
	slider_selected=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0), real_x-2*size,real_y+14*size,real_x+11*size,real_y+14*size+10*4*size)
	option_hover=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0), real_x-2*size,real_y+14*size+41*size,real_x+11*size,real_y+14*size+45*size)
	if option_hover && mouse_check_button_pressed(mb_left)
	{
		show_options=!show_options
		clicksound()
	}
	
	if ! slider_clicked_on{
		calc_slider_y()
		if slider_selected && mouse_check_button_pressed(mb_left)
		{
			slider_clicked_on=true
			clicksound()
		}
	}
	else
	{
		if !mouse_check_button(mb_left)
		{
			slider_clicked_on=false
		}
		else
		{
			var slider_real_y=real_y+18*size+27*size-clamp(device_mouse_y_to_gui(0),real_y+18*size,real_y+27*size+18*size)
			var amount_needed=round(slider_real_y*useful_goons_count()/(27*size))
			while amount_needed>gooning_goons_count() && gooning_goons_count()<useful_goons_count()
			{
				select_nearest.func()
			}
			while amount_needed<gooning_goons_count() && gooning_goons_count()>0
			{
				unselect_nearest.func()
			}
			calc_slider_y()
			
		}
	}
}
else
{
	slider_clicked_on=false
}


event_inherited();

calc_slider_y()