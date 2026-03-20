if current_potion!="empty"
{
	if potion_show_size<7
	{potion_show_size++}
	draw_calories_objective(bbox_right+200,bbox_bottom-10,current_potion,0,potion_show_size)
	var showd=point_in_rectangle(mouse_x,mouse_y,bbox_right+200-10*scale,bbox_bottom-10-10*scale,bbox_right+200+10*scale,bbox_bottom-10+10*scale)
	with(obj_brewery_item)
	{
		if held || show_data
		{
			showd=false
		}
	}
	if showd{
		draw_calories_objective(bbox_right+200,bbox_bottom-10,current_potion,0,potion_show_size,true)
		draw_nametag_gui(item_get_name(current_potion))
		item_draw_box_datas(current_potion,device_mouse_x_to_gui(0)-8,device_mouse_y_to_gui(0)+65,3)
	}
}