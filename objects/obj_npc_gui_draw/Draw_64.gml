
var change_mod=change_modifier_npc/change_modifier_npc_max
var change_mod_sec=change_modifier_npc_second/change_modifier_npc_max
	

for (var i=0;i<array_length(global.npc_data.room_tiles);i++)
{
	var tile=global.npc_data.room_tiles[i]
	var spr=tile.sprite_id
	var  size=tile.size
	size=max(min(size,1),size*(1-change_mod))
	var xx=tile.x_coord
	var yy=tile.y_coord
	
	draw_sprite_ext(spr,floor((current_time/1000)*sprite_get_speed(spr))%sprite_get_number(spr),xx,yy,size,size,0,c_white,1)
}
if change_modifier_npc==0
{
	for (var i=0;i<array_length(global.npc_data.offerings);i++)
	{
		var tile=global.npc_data.offerings[i]
		var item_id=  tile.item_id
		var  size=tile.size
		var costmoney_size=3
		size=max(min(size,1),size*(1-change_mod_sec))
		if i==hovering_offering_index
		{
			costmoney_size*=1.1
			size*=1.1
		}
		var xx=tile.x_coord
		var yy=tile.y_coord
		var costmoney_sprite=spr_textbox
		
		//draw_sprite_ext(spr,floor((current_time/1000)*sprite_get_speed(spr))%sprite_get_number(spr),xx,yy,size,size,0,c_white,1)
		draw_item(xx,yy,item_id,size,1,tile.shadow)
		if i==hovering_offering_index
		{
			var linewidth=size
			gpu_set_fog(true,c_white,0,0)
			draw_item(xx+linewidth,yy,item_id,size)
			draw_item(xx-linewidth,yy,item_id,size)
			draw_item(xx,yy+linewidth,item_id,size)
			draw_item(xx,yy-linewidth,item_id,size)
			gpu_set_fog(false,c_white,0,0)
			costmoney_sprite=spr_textbox_selected_true
		}
		draw_item(xx,yy,item_id,size)
		var item_spr=item_get_sprite(item_id)

		if tile.cost_money>0
		{
			var bbox_bottom_coords=tile.size*(sprite_get_bbox_bottom(item_spr)-sprite_get_yoffset(item_spr))+18-(costmoney_size-3)*3
			var bbox_left_coords=tile.size*(sprite_get_bbox_left(item_spr)-sprite_get_xoffset(item_spr))-(costmoney_size-3)*10
			if draw_money_box_cost_gui(xx+bbox_left_coords,yy+bbox_bottom_coords	,spr_coin_small,tile.cost_money,costmoney_size,costmoney_sprite)
			{
				hovering_offering_textbox_sprite=i
			}
		}
	}
}
if global.npc_data.active_quests_show.show
{
	var startcoords=global.npc_data.active_quests_show.topleft_coord
	var yy=startcoords[1]
	var size=global.npc_data.active_quests_show.size
	for (var i=0;i<array_length(global.npc_data.active_quests);i++)
	{

		var ret=npc_draw_quest(global.npc_data.active_quests[i],startcoords[0],yy,size*(1-change_mod))
		yy+=ret[1]+10*size
		if ret[0]
		{
			hovering_quest_index=i
			if ret[2]=="empty"
			{
				hovering_text=global.npc_data.active_quests[i].name
			}
			else
			{
				hovering_offering_item_id=ret[2]
			}
		}
	}
	


}
if global.npc_data.show_npc
{
	var spr=global.npc_data.npc_to_draw.sprite
	var size=global.npc_data.npc_to_draw.size
	var drawxplus=200*change_mod
	var drawyplus=120*change_mod
	size+=size*change_mod
	draw_sprite_ext(spr,floor((current_time/1000)*sprite_get_speed(spr))%sprite_get_number(spr),npc_draw_x+drawxplus,npc_draw_y+drawyplus,size,size,0,c_white,1)
	


}
if global.npc_data.nearby_items_show.show{
	var dt=global.npc_data.nearby_items_show
	var output=npc_show_item_array(dt,global.npc_room_nearby_items,true)
	if output!="empty"
	{
		hovering_offering_item_id=output
	}
}
if global.npc_data.returning_items_show.show{
	var dt=global.npc_data.returning_items_show
	var output=npc_show_item_array(dt,returning_items,true)
	if output!="empty"
	{
		hovering_offering_item_id=output
	}

}


if global.npc_data.show_money
{
	var size=max(1,6*(1-change_mod))
	if draw_money_box_gui(14+5*sin(coin_shake_meter),10,coin_spr,size)
	{
		coin_spr=spr_coin_touched
	
	}
	else
	{
		coin_spr=spr_coin
	}
	

}

if hovering_offering_item_id!="empty" || hovering_text!="empty"
{
	if hovering_text!="empty"
	{
		draw_nametag_gui(hovering_text)
	}
	else{
		draw_nametag_gui(item_get_name(hovering_offering_item_id))
		item_draw_box_datas(hovering_offering_item_id,device_mouse_x_to_gui(0)-8,device_mouse_y_to_gui(0)+65,3)
	}

}