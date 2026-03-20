if held || show_data{
	draw_sprite_ext(sprite_active,sprite_get_current_subimg(sprite_active),x+rot_diff_x,y+rot_diff_y,size,size,rotation,c_white,1)
}

if show_data
{
	draw_nametag_gui(item_get_name(item_id))
		item_draw_box_datas(item_id,device_mouse_x_to_gui(0)-8,device_mouse_y_to_gui(0)+65,3)
}