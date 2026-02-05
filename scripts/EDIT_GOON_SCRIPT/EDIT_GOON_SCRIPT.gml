function exit_goon_edit_mode()
{
	if global.goon_edit_mode
	{
		with (obj_edit_goon)
		{
			global.goon_edit_mode=false
			global.goon_edit_id=noone
			instance_destroy()
		}
	}

}

function edit_goon(_id)
{
	if !global.special_mode
	{
		global.last_selected_goon=_id
		global.goon_edit_id=_id
		instance_create_depth(x,y,depth,obj_edit_goon)
	}
	else if global.goon_edit_id!=_id
	{
		global.last_selected_goon=_id
		global.goon_edit_id=_id
	}

}




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
	if _id.goto_x!=_id.x || _id.goto_y!=_id.y || array_length(_id.goto_list)!=0
	{
		array_push(buttons,"stop")
	}
	if _id.equipment!="empty"
	{
		array_push(buttons,"unequip")
	}
	else if item_tags_contains(_id.inventory,"equippable")
	{
		array_push(buttons,"equip")
	}
	return buttons
}

function edit_button_pressed(pressed_id)
{
	var pressed_function =function(_id){}
	pressed_function=get_edit_button_data(pressed_id).act
	pressed_function(global.goon_edit_id)

}


function get_edit_button_data(button_name)
{
	var data={realname:"Button",act:function(_id){}}
	switch button_name
	{
		case "pickup":
			data.realname="Switch Items"
			data.act=function(_id)
			{
				with(_id)
				{
					put_down_item()
					interact_function()
				}
			}
			break
		case "put_down":
			data.realname="Drop Item"
			data.act=function(_id)
			{
				with(_id)
				{
					put_down_item()
				}
			}
			break
		case "select":
			data.realname="Select Goon"
			data.act=function(_id)
			{
				with(_id)
				{
					sound_play_category_at("murr",x,y)
					gooning=true
				}
			}
			break
		case "unselect":
			data.realname="Unselect Goon"
			data.act=function(_id)
			{
				with(_id)
				{
					gooning=false
				}
			}
			break
			
		case "stop":
			data.realname="Stop"
			data.act=function(_id)
			{
				with(_id)
				{
					stop_goon()
				}
			}
			break
		case "equip":
			data.realname="Equip"
			data.act=function(_id)
			{
				with(_id)
				{
					equip_item_from_hand()
				}
			}
			break
		case "unequip":
			data.realname="Unequip"
			data.act=function(_id)
			{
				with(_id)
				{
					unequip_item()
				}
			}
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