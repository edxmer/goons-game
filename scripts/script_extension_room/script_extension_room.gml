function goto_extension_room_main_menu(room_id){
	if asset_get_type(room_id)== asset_room
	{
		room_persistent = true
		global.pause_sprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
		room_goto(room_id)
	
	}
}

function npc_create_offering_data_base()
{
	var empty={item_id:"empty",
		cost_money:0,
		x_coord:0,
		y_coord:0,
		size:5,
		shadow:true
		}
	return empty
}
function npc_create_offering_data(item_id,size,x_coord,y_coord,cost_money,shadow=true)
{
	var offering=npc_create_offering_data_base()
	offering.item_id=item_id
	offering.cost_money=cost_money
	offering.size=size
	offering.x_coord=x_coord
	offering.y_coord=y_coord
	offering.shadow=shadow
	return offering


}
function npc_delete_item(item_id)
{
	if array_contains(global.npc_room_nearby_items,item_id)
	{
		array_delete(global.npc_room_nearby_items,array_get_index( global.npc_room_nearby_items,item_id),1)
		array_push(global.npc_room_transfer_items_to_destroy,item_id)
		return true
	}
	return false
}

function npc_create_quest(name,subtext,required_items,required_bool,reward_items)
{
	var quest_struct=npc_create_quest_base()
	quest_struct.required_bool=required_bool
	quest_struct.name=name
	quest_struct.subtext=subtext
	quest_struct.required_items=required_items	
	quest_struct.reward_items=reward_items	
	return quest_struct
}

function npc_draw_quest(quest_struct,txx,tyy,size,px_width=170)
{
	var xx=txx
	var yy=tyy
	var spacing=5
	var text_mult=0.25
	var text_mult_sub=0.2
	var space1=max(0.5*(spacing+12),string_height_ext(quest_struct.name,string_height(quest_struct.name)+spacing,px_width)*text_mult)
	var space2=string_height_ext(quest_struct.subtext,string_height(quest_struct.subtext)+spacing,px_width*0.5)*text_mult_sub
	var height=3*spacing+space1+space2
	spacing*=size
	var txt_texture=spr_textbox
	var line_index=0
	var selected=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),xx,yy,xx+px_width*size,yy+height*size)
	if selected
	{
		line_index=1
		txt_texture=spr_textbox_selected_true
		size*=1.03
		xx-=px_width*size*0.015
		yy-=height*size*0.015
		txx-=px_width*size*0.015
		tyy-=height*size*0.015
	}
	space1=max(0.5*(spacing+12*size),string_height_ext(quest_struct.name,string_height(quest_struct.name)+spacing,px_width)*text_mult)
	draw_box_pxs(xx,yy,px_width,height,size,txt_texture)
	draw_set_font(fnt_nametag)
	draw_set_halign(textalign_justify)
	draw_set_valign(textalign_top)
	draw_set_colour(c_black)
		draw_sprite_ext(spr_textbox_underline,line_index,xx+2*size+px_width*0.5*size,yy+spacing*2+space1,px_width*size/4,size,0,c_white,1)
	draw_text_ext_transformed_bold(xx+spacing*2,yy+spacing*0.8,quest_struct.name,string_height(quest_struct.name)+spacing,px_width,text_mult*size,text_mult*size,0)
	yy+=space1+spacing

	draw_set_font(fnt_nametag_subtext)
	draw_text_ext_transformed(xx+spacing*2.5,yy+2*spacing,quest_struct.subtext,string_height(quest_struct.subtext),(( 0.7* px_width) / (text_mult_sub * size)),text_mult_sub*size,text_mult_sub*size,0)
	var ixx=xx+px_width*0.5*size+12*size*0.5
	var iyy=tyy+12*size*0.5+spacing*0.75
	for (var i=0;i<array_length(quest_struct.required_items );i++)
	{
		draw_calories_objective(ixx,iyy,quest_struct.required_items[i],0,size*0.75)
		ixx+=16*0.75*size+2*size
		if ixx>xx+px_width*size-spacing-12*0.5*size
		{
			ixx=xx+px_width*0.5*size+12*size*0.5
			iyy+=16*0.75*size+2*size
		}
	}
	return [selected,height*size]
}


function npc_create_quest_base()
{
	var quest={name:"Quest",subtext:"This is a quest.",required_items:["banana"],required_bool:function(){return true},reward_items:["banana"]}
	return quest
}

function npc_create_room_tile_data_base()
{
	var empty={sprite_id:spr_empty,size:5,x_coord:0,y_coord:0}
	return empty
}

function npc_create_room_tile_data(sprite_id,size,x_coord,y_coord)
{
	var offering=npc_create_offering_data_base()
	offering.sprite_id=sprite_id
	offering.size=size
	offering.x_coord=x_coord
	offering.y_coord=y_coord
	return offering


}

function npc_room_data_get_base()
{
	var data={show_money:false,
		show_npc:false,
		npc_to_draw:{sprite:spr_crop_seller,size:4,sound:"empty"},
		offerings:[npc_create_offering_data_base()],
		room_tiles:[npc_create_room_tile_data_base()],
		returning_items_show:npc_get_base_item_show_struct(),
		nearby_items_show:npc_get_base_item_show_struct(),
		active_quests_show:{show:false,topleft_coord:[0,0],size:2},
		active_quests:[]
		
		
		}
	return data

}

function npc_get_base_item_show_struct()
{
	var array={show:true,startx:0,starty:0,spacingx:0,spacingy:0,size:1,shadow:true,clampx:-1,clampy:-1}
	return array
}

function npc_show_item_array(how,item_datas,do_outline=false)
{
	var out="empty"
	var dt=how
	var startx=dt.startx
	var starty=dt.starty
	var size=dt.size
	var spacingx=dt.spacingx
	var spacingy=dt.spacingy
	var shadow=dt.shadow
	var done_outline=true
	if do_outline
	{
		done_outline=false
	}
	for (var i=0;i<array_length(item_datas);i++)
	{
		if do_outline && !done_outline
		{

			if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),startx-8*size,starty-8*size,startx+8*size,starty+8*size)
			{
				
				out=item_datas[i]
				done_outline=true
				gpu_set_fog(true,c_white,0,0)
				draw_item(startx+1*size,starty,item_datas[i],size,1,false,true)
				draw_item(startx-1*size,starty,item_datas[i],size,1,false,true)
				draw_item(startx,starty+1*size,item_datas[i],size,1,false,true)
				draw_item(startx,starty-1*size,item_datas[i],size,1,false,true)
				gpu_set_fog(false,c_white,0,0)
			}
		}
		draw_item(startx,starty,item_datas[i],size,1,shadow,true)
		startx+=spacingx
		starty+=spacingy
		if dt.clampx>=0
		{
			if startx>=dt.clampx
			{
				startx=dt.startx
			}
		}
		if dt.clampy>=0
		{
			if startx>=dt.clampy
			{
				starty=dt.starty
			}
		}
	}
	return out

}