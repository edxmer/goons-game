if global.special_mode
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
		var path_select_mode=true
		with(obj_goon){
		if position_meeting(mouse_x,mouse_y,id) &&!gooning
			{
				sound_play_category_at("murr",id.x,id.y)
				gooning=true
				other.goons_selected++
				path_select_mode=false
			}
		}
		if path_select_mode{
			global.select_mode=false
			instance_create_depth(mouse_x,mouse_y,0,obj_cursor_go_goons)
		}
	}

}

if mouse_check_button(mb_left) && global.select_mode
{
	var gooned=0
	with(obj_goon){
		if position_meeting(mouse_x,mouse_y,id)
		{
			global.last_selected_goon=id
			if !gooning{
				sound_play_category_at("murr",id.x,id.y)
				gooning=true
				gooned++
			}
		}
	}
	goons_selected+=gooned

}


	if mouse_check_button_released(mb_left) 
	{
		if global.select_mode && gooning_goons_count()==0
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
				global.last_selected_goon=closest_idle
				closest_idle.gooning=true
					sound_play_category_at("murr",closest_idle.x,closest_idle.y)
				goon_if_gooning_goto_coords(closest_idle,mouse_x,mouse_y)
			}
		}
		else if instance_exists(obj_cursor_go_goons)
		{
			
			var goon_goto=[]
			with (obj_cursor_go_goons)
			{
				goon_goto=death_data_push()
				
						
					goon_if_gooning_goto_coords(obj_goon,mouse_x,mouse_y,goon_goto[0],goon_goto[1])
				
			}
		
		}
	}

}
