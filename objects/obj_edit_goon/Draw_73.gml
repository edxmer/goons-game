depth=global.goon_edit_id.depth-10

if global.special_zoom_done{
	var returnval= goon_edit_buttons(buttons_last,selected_button_last)
	buttons_last=returnval[0]
	selected_button_last=returnval[1]
	if mouse_check_button_pressed(mb_left) && selected_button_last!=-1
	{
		edit_button_pressed(buttons_last[selected_button_last])
	}
}