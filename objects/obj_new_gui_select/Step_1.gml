// Inherit the parent event

if active
{
	signs=[select_all,select_nearest,unselect_nearest,unselect_all,reset_zoom]
	if show_options
	{
		var options_b=options_changes_current.signs
		signs=[select_all,select_nearest,unselect_nearest,unselect_all]
		for(var i=0;i<array_length(options_b);i++)
		{
			array_push(signs,options_b[i])
		}
		array_push(signs,reset_zoom)
	}
	slider_selected=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0), real_x-2*size,real_y+14*size,real_x+11*size,real_y+14*size+10*4*size)
	option_hover=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0), real_x-2*size,real_y+14*size+41*size,real_x+11*size,real_y+14*size+45*size)
	if option_hover && mouse_check_button_pressed(mb_left)
	{
		show_options=!show_options
		clicksound()
	}
	option_change_hover=show_options&&point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0), real_x-35*size-7*size,real_y+18*size+4*sign_size*size-7*size,real_x-35*size+9*size-1,real_y+18*size+4*sign_size*size+12*size)
	if option_change_hover && mouse_check_button_pressed(mb_left)
	{
		options_changes_index=(options_changes_index+1)%array_length(options_changes)
		options_changes_current=options_changes[options_changes_index]
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

if sign_selected!=-1 && show_options&& signs[sign_selected].spr==spr_ui_icon_button_option
{
	mark_only_id=sign_selected
	mark_only_yy=real_y+18*size+sign_size*sign_selected*size
}
else if show_options
{
	if device_mouse_y_to_gui(0)>real_y +18*size && device_mouse_y_to_gui(0)+18*size+ array_length(signs)*size*sign_size
	{
		var yy=round((device_mouse_y_to_gui(0)-(real_y +18*size))/(size*sign_size))
		if yy<array_length(signs) && yy>=0 && signs[yy].spr==spr_ui_icon_button_option
		{
			mark_only_id=yy
			mark_only_yy=real_y+18*size+sign_size*yy*size
		}
		
	}
}
if mark_only_id!=-1
{
	if mark_only_yy+sign_size*0.5*size<device_mouse_y_to_gui(0) || mark_only_yy-sign_size*0.5*size>device_mouse_y_to_gui(0)
	{
		mark_only_id=-1
	}
	else
	{
		mark_selected=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),real_x+11*size,mark_only_yy-sign_size*0.5*size,real_x+23*size,mark_only_yy+sign_size*0.5*size)
		if mark_selected && mouse_check_button_pressed(mb_left)
		{
			clicksound()
			undo_all_other(mark_only_id)
	
		}
	}
}

if !active || !show_options
{
	mark_only_id=-1
}


calc_slider_y()