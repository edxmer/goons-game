if !instance_exists(global.goon_edit_id)
{
instance_destroy()
}

depth=global.goon_edit_id.depth-10



if global.special_zoom_done{
	var size=global.camera_size
	var curr_x=0
	var curr_y=0
	
	
	
	
	var spaces=[0,0]
	var spaces_eq=[0,0]
	
	
	if global.goon_edit_id.inventory!="empty"{
		curr_x=global.cam.coords[0]+20*size+2*20*size
		curr_y=global.cam.coords_middle[1]
		var selected=false
		var drawsize=size
		if selected_inventory{
			spaces=item_draw_box_datas_for_goon_ui_width_and_height(global.goon_edit_id.inventory,curr_x,curr_y,size,"Inventory:")
			selected=point_in_rectangle(mouse_x,mouse_y,curr_x,curr_y,curr_x+(12+spaces[0])*size,curr_y+spaces[1]*size)

			item_draw_box_datas_for_goon_ui(global.goon_edit_id.inventory,curr_x,curr_y,drawsize,"§bInventory:",selected)
		}
		else
		{
			spaces=draw_box_data_get_width_and_height(["> Inventory:",item_get_name(global.goon_edit_id.inventory)],[],curr_x,curr_y,size)
			selected=point_in_rectangle(mouse_x,mouse_y,curr_x,curr_y,curr_x+(12+spaces[0])*size,curr_y+spaces[1]*size)

			var texture=spr_textbox
			if selected{texture=spr_textbox_selected_true}
			draw_box_datas(["§b> Inventory:",item_get_name(global.goon_edit_id.inventory)],[],curr_x,curr_y,drawsize,3,texture)


		}
		if mouse_check_button_pressed(mb_left) && selected
		{
			sound_play_category_at("swoosh",mouse_x,mouse_y)
			selected_inventory=!selected_inventory
			selected_equipment=false
		}
	}
	if global.goon_edit_id.equipment!="empty"{
		curr_x=global.cam.coords[0]+20*size+2*20*size
		curr_y=global.cam.coords_middle[1]+(spaces[1])*size+4*size
		var selected=false
		var drawsize=size
		if selected_equipment{
			spaces_eq=item_draw_box_datas_for_goon_ui_width_and_height(global.goon_edit_id.equipment,curr_x,curr_y,drawsize,"Equipment:")
			selected=point_in_rectangle(mouse_x,mouse_y,curr_x,curr_y,curr_x+(12+spaces_eq[0])*size,curr_y+spaces_eq[1]*size)



			item_draw_box_datas_for_goon_ui(global.goon_edit_id.equipment,curr_x,curr_y,drawsize,"§bEquipment:",selected)
			
		}
		else
		{
			spaces_eq=draw_box_data_get_width_and_height(["> Equipment:",item_get_name(global.goon_edit_id.equipment)],[],curr_x,curr_y,size)
			selected=point_in_rectangle(mouse_x,mouse_y,curr_x,curr_y,curr_x+(12+spaces_eq[0])*size,curr_y+spaces_eq[1]*size)

			var texture=spr_textbox
			if selected{texture=spr_textbox_selected_true}
			draw_box_datas(["§b> Equipment:",item_get_name(global.goon_edit_id.equipment)],[],curr_x,curr_y,drawsize,3,texture)
			

			
		}
		if  selected && mouse_check_button_pressed(mb_left)
		{
			sound_play_category_at("swoosh",mouse_x,mouse_y)
			selected_inventory=false
			selected_equipment=!selected_equipment
		}
	}
	//effects
	var eff_spaces=[0,0]
	if array_length(global.goon_edit_id.active_effect_list)>0{
		curr_x=global.cam.coords[0]+20*size
		curr_y=global.cam.coords_middle[1]-20*size
		var selected=false
		if selected_effects{
			
			eff_spaces=draw_box_data_get_width_and_height(["Effects:",item_get_name(global.goon_edit_id.inventory)],[],curr_x,curr_y,size)
			selected=point_in_rectangle(mouse_x,mouse_y,curr_x,curr_y,curr_x+(12+eff_spaces[0])*size,curr_y+eff_spaces[1]*size)
			var texture=spr_textbox
			if selected{texture=spr_textbox_selected_true}
			draw_box_datas(["§bEffects:"],[],curr_x,curr_y,size,3,texture)
			curr_y+=size*14-0.5
			curr_x+=size*4
			effect_draw_icons(global.goon_edit_id.active_effect_list,curr_x,curr_y,4,1.4*size,1)
		}
		else
		{
			eff_spaces=draw_box_data_get_width_and_height(["> Effects:",item_get_name(global.goon_edit_id.inventory)],[],curr_x,curr_y,size)
			selected=point_in_rectangle(mouse_x,mouse_y,curr_x,curr_y,curr_x+(12+eff_spaces[0])*size,curr_y+eff_spaces[1]*size)
			var texture=spr_textbox
			if selected{texture=spr_textbox_selected_true}
			draw_box_datas(["§b> Effects:"],[],curr_x,curr_y,size,3,texture)
		}
		if selected && mouse_check_button_pressed(mb_left)
		{
			sound_play_category_at("swoosh",mouse_x,mouse_y)
			selected_effects=!selected_effects
			
		}
	}
	//effects_end
	var returnval= goon_edit_buttons(buttons_last,selected_button_last)
	buttons_last=returnval[0]
	selected_button_last=returnval[1]
	if mouse_check_button_pressed(mb_left) && selected_button_last!=-1
	{
		edit_button_pressed(buttons_last[selected_button_last])
	}
}