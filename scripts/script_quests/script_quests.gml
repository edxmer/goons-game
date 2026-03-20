function evaluate_quests(quest=npc_create_quest_base(),items_nearby=[]){
	var needed_items=quest.required_items
	if quest.required_bool() && is_subset(items_nearby,needed_items)
	{
		return true
	}
	else
	{
		return false
	}
}

function npc_evaluate_quest(quest)
{
	return evaluate_quests(quest,global.npc_room_nearby_items)
}

function npc_delete_items(item_list)
{
	for (var i=0;i<array_length(item_list);i++)
	{
		npc_delete_item(item_list[i])
	}
}
function npc_add_items(item_list)
{
	for (var i=0;i<array_length(item_list);i++)
	{
		array_push(global.npc_room_transfer_items,(item_list[i]))
	}

}

function npc_accept_quest(quest)
{
	if npc_evaluate_quest(quest)
	{
		npc_delete_items(quest.required_items)
		npc_add_items(quest.reward_items)
	}
}

function npc_create_quest_base()
{
	var quest={name:"Quest",subtext:"This is a quest.",required_items:["banana"],required_bool:function(){return true},reward_items:["banana"]}
	return quest
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
	var item_selected="empty"
	var spacing=5
	var text_mult=0.25
	var text_mult_sub=0.2
	var space1=max(0.5*(spacing+12),string_height_ext(quest_struct.name,string_height(quest_struct.name)+spacing,px_width)*text_mult)
	var space2=string_height_ext(quest_struct.subtext,string_height(quest_struct.subtext)*text_mult_sub+spacing,px_width*0.5/(text_mult_sub*size))*text_mult_sub
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
	draw_text_ext_transformed(xx+spacing*2.5,yy+2*spacing,quest_struct.subtext,string_height(quest_struct.subtext),(( 0.8* px_width) / (text_mult_sub * size)),text_mult_sub*size,text_mult_sub*size,0)
	var ixx=xx+px_width*0.5*size+12*size*0.5
	var iyy=tyy+12*size*0.5+spacing*0.75
	var sizesmall=0.75
	for (var i=0;i<array_length(quest_struct.required_items );i++)
	{
		draw_calories_objective(ixx,iyy,quest_struct.required_items[i],0,size*sizesmall)
		if selected && point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),ixx-12*size*sizesmall,iyy-12*size*sizesmall,ixx+12*size*sizesmall,iyy+12*size*sizesmall)
		{
			item_selected=quest_struct.required_items[i]
		}
		ixx+=16*0.75*size+2*size
		if ixx>xx+px_width*size-spacing-12*0.5*size
		{
			ixx=xx+px_width*0.5*size+12*size*0.5
			iyy+=16*0.75*size+2*size
		}
	}
	ixx=xx+px_width*0.5*size+14*size*0.5
	iyy=tyy+space1+14*size*0.5+spacing*2.1
	sizesmall=0.8
	for (var i=0;i<array_length(quest_struct.reward_items );i++)
	{
		draw_calories_objective(ixx,iyy,quest_struct.reward_items[i],2,size*sizesmall)
		if selected && point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),ixx-12*size*sizesmall,iyy-12*size*sizesmall,ixx+12*size*sizesmall,iyy+12*size*sizesmall)
		{
			item_selected=quest_struct.reward_items[i]
		}
		ixx+=16*0.75*size+2*size
		if ixx>xx+px_width*size-spacing-14*0.5*size
		{
			ixx=xx+px_width*0.5*size+14*size*0.5
			iyy+=16*0.75*size+2*size
		}
	}
	return [selected,height*size,item_selected]
}
