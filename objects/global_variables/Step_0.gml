
global.is_hovering_gui = 0 < array_length(global.gui_hovering)

global.special_mode=global.goon_edit_mode || global.reward_mode || global.pause_menu
layer_depth("vignette",-room_height)
if global.special_mode
{
	layer_set_visible("vignette_special_mode",true)
	layer_depth("vignette_special_mode",-room_height)
	if global.reward_mode
	{
		with(obj_work_station)
		{
			if station_id=="primordeal_goo"
			global.special_coords=[x,y]
		}
	}
}
else
{
	layer_set_visible("vignette_special_mode",false)
}

if mouse_check_button_pressed(mb_middle)
{
	create_save("save")

}

