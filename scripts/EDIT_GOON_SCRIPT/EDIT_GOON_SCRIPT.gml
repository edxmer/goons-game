function goon_get_buttons(_id){
	var buttons=[]
	array_push(buttons,"pickup")
	if _id.inventory!="empty"
	{
		array_push(buttons,"put_down")
	}
	if _id.gooning
	{
		array_push(buttons,"unselect")
	}
	else{
		array_push(buttons,"select")
	}
	if !goon_is_idle(_id,[_id.inventory])
	{
		array_push(buttons,"stop")
	}
	return buttons
}

function get_edit_button_data(button_name)
{
	var data={realname:"Button",act:function(_id){}}
	switch button_name
	{
		case "pickup":
			data.realname="Switch Items"
			break
		case "put_down":
			data.realname="Drop Item"
			break
		case "select":
			data.realname="Select Goon"
			break
		case "unselect":
			data.realname="Unselect Goon"
			break
		case "stop":
			data.realname="Stop"
			break

	}
	return data
}



function goon_show_buttons(buttons_cur,buttons_last,name,lastselectedindex)
{
	var cur_selected=-1
	var size_global=global.camera_size
	draw_set_font(fnt_nametag)
	draw_set_halign(textalign_center)
	draw_set_valign(textalign_middle )
	draw_set_colour(#101119)
	draw_sprite_ext(spr_nametag,0,global.cam.coords_middle[0],global.cam.coords_middle[1]-size_global*40,size_global*2,size_global*2,0,c_white,1)
	
	draw_text_ext_transformed(global.cam.coords_middle[0],global.cam.coords_middle[1]-size_global*48,name,1.2,1000*size_global,size_global*0.4,size_global*0.4,0)
	var startx=global.cam.coords_middle[0]+size_global*30
	var starty=global.cam.coords_middle[1]-size_global*15
	var half_sprite_width=(sprite_get_bbox_right(spr_nametag)-sprite_get_bbox_left(spr_nametag))*0.5
	var half_sprite_height=(sprite_get_bbox_bottom(spr_nametag)-sprite_get_bbox_top(spr_nametag))*0.5
	for (var i=0;i<array_length(buttons_cur);i++)
	{
		var selected= point_in_rectangle(mouse_x,mouse_y,startx-half_sprite_width,starty-half_sprite_height,startx+half_sprite_width,starty+half_sprite_height)
		var button_cur=buttons_cur[i]
		var size=size_global
		var plusx=0
		if !array_contains(buttons_last,button_cur)
		{
			size*=0.5
		}
		
		else if selected{
			cur_selected=i
			plusx=7*size_global
			if lastselectedindex==i
			{
				draw_sprite_ext(spr_nametag_arrow,0,startx,starty,size,size,0,c_white,1)
				plusx*=1.25
			}
			
		}
		draw_sprite_ext(spr_nametag,0,startx+plusx,starty,size,size,0,c_white,1)
		if array_contains(buttons_last,button_cur)
		{
			var bname=get_edit_button_data(button_cur).realname
			draw_text_ext_transformed(startx+plusx,starty-size_global*3.5,bname,1.2,1000*size_global,size_global*0.2,size_global*0.2,0)
		}
		starty+=15*size_global
	
	}
	draw_set_halign(textalign_left)
	draw_set_valign(textalign_top )
	if cur_selected!=lastselectedindex
	{
		sound_play_category_at("swoosh",startx,starty)
	}
	
	return cur_selected
}


function goon_edit_buttons(buttons_last,last_selected_index)
{
	 var buttons_cur=goon_get_buttons(global.goon_edit_id)
	 var cur_selected=goon_show_buttons(buttons_cur,buttons_last,global.goon_edit_id.name,last_selected_index)
	 return [buttons_cur,cur_selected]
}