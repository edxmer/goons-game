if global.reward_mode
{
	exit
}

if (!global.is_hovering_gui) { // goon

if mouse_check_button_pressed(mb_left)
{
	var goons=0
	with(obj_goon){
		if gooning{
			goons++
		}
	}
	if goons==0{
		global.select_mode=true
		goons_selected=0
	}
	else{
		global.select_mode=false

					with(obj_goon){
						
						goon_if_gooning_goto_coords(id,mouse_x,mouse_y)
					}
					
			

	}

}

if mouse_check_button(mb_left) && global.select_mode
{
	var gooned=0
	with(obj_goon){
		if position_meeting(mouse_x,mouse_y,id) && !gooning{
			sound_play_category_at("murr",id.x,id.y)
			gooning=true
			gooned++
		}
	}
	goons_selected+=gooned

}


if mouse_check_button_released(mb_left) && global.select_mode && goons_selected==0
{
	var items_searched_for=["empty"]
	var selected_ws=workstation_selected_id()
	if selected_ws!=noone
	{
		if selected_ws.crafting==true
		{
			items_searched_for=selected_ws.crafting_input_ids
		}
	}
	var closest_idle=goons_get_closest_idle(mouse_x,mouse_y,items_searched_for)
	if closest_idle==noone
	{
		closest_idle=goons_get_closest_idle(mouse_x,mouse_y)
	}
	if closest_idle!=noone
	{
		closest_idle.gooning=true
			sound_play_category_at("murr",closest_idle.x,closest_idle.y)
		goon_if_gooning_goto_coords(closest_idle,mouse_x,mouse_y)
	}
}


}
