//global.special_coords=[global.goon_edit_id.x,global.goon_edit_id.y]
if global.reward_mode || (!instance_exists(global.goon_edit_id)) ||(was_right_pressed &&mouse_check_button(mb_right) && last_id==global.goon_edit_id) || (keyboard_check(ord("W"))||keyboard_check(ord("S"))||keyboard_check(ord("A"))||keyboard_check(ord("W"))||(keyboard_check(ord("D"))))
{
	global.goon_edit_mode=false
	global.goon_edit_id=noone
	instance_destroy()
}
else
{
	global.special_coords=[global.goon_edit_id.x+15*global.camera_size,global.goon_edit_id.y+10*global.camera_size]
}


last_id=global.goon_edit_id
was_right_pressed=mouse_check_button_pressed(mb_right)