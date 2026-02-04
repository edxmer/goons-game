//global.special_coords=[global.goon_edit_id.x,global.goon_edit_id.y]
if global.reward_mode || (!instance_exists(global.goon_edit_id)) ||(was_right_pressed &&mouse_check_button(mb_right) && last_id==global.goon_edit_id) 
{
	exit_goon_edit_mode()
}
else
{
	global.special_coords=[global.goon_edit_id.x+15*global.camera_size,global.goon_edit_id.y+10*global.camera_size]
	if (keyboard_check(ord("W"))||keyboard_check(ord("S"))||keyboard_check(ord("A"))||(keyboard_check(ord("D"))))
	{
		with(global.goon_edit_id)
		{
			//stop_goon()
			goto_x=x+(keyboard_check(ord("D"))-keyboard_check(ord("A")))*delta_time/1000000*goon_speed*3
			goto_y=y+(keyboard_check(ord("S"))-keyboard_check(ord("W")))*delta_time/1000000*goon_speed*3
			
		}
	}
}


last_id=global.goon_edit_id
was_right_pressed=mouse_check_button_pressed(mb_right)