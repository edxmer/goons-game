

if change_modifier_npc>0
{
	change_modifier_npc--
}
else if change_modifier_npc_second>0
{
	change_modifier_npc_second--

}
var change_mod=change_modifier_npc/change_modifier_npc_max
var change_mod_sec=change_modifier_npc_second/change_modifier_npc_max

if coin_shake_meter>0
{
	coin_shake_meter-=60
	coin_shake_meter=max(0,coin_shake_meter)
}



hovering_offering_index=hovering_offering_textbox_sprite
hovering_offering_item_id="empty"
hovering_text="empty"
if global.npc_data.active_quests_show.show && hovering_quest_index!=-1
{
	var quest=global.npc_data.active_quests[hovering_quest_index]
	if  mouse_check_button_pressed(mb_left) && npc_evaluate_quest(quest)
	{
		npc_accept_quest(quest)
		array_delete(global.npc_data.active_quests,hovering_quest_index,1)
	}
}
hovering_quest_index=-1


if hovering_offering_textbox_sprite!=-1
{
	hovering_offering_item_id=global.npc_data.offerings[hovering_offering_textbox_sprite].item_id
}
hovering_offering_textbox_sprite=-1

if change_modifier_npc_second==0
{
	for (var i=0;i<array_length(global.npc_data.offerings);i++)
	{
		
		var tile=global.npc_data.offerings[i]
		var item_id=  tile.item_id
		var  size=tile.size*1.1
		var xx=tile.x_coord
		var yy=tile.y_coord
	
		
		var spr=item_get_sprite(item_id)
		var offsetx=sprite_get_xoffset(spr)
		var offsety=sprite_get_yoffset(spr)
		var down_coord_y=yy+size*(sprite_get_bbox_bottom(spr)-offsety)
		var up_coord_y=yy+size*(sprite_get_bbox_top(spr)-offsety)
		var down_coord_x=xx+size*(sprite_get_bbox_right(spr)-offsetx)
		var up_coord_x=xx+size*(sprite_get_bbox_left(spr)-offsetx)
		if point_in_rectangle(mouse_x,mouse_y,up_coord_x,up_coord_y,down_coord_x,down_coord_y)
		{
			hovering_offering_item_id=item_id
			hovering_offering_index=i
			break
		}
	}




}

if global.npc_data.show_npc && mouse_check_button_pressed(mb_left)
{
	var spr=global.npc_data.npc_to_draw.sprite
	var size=global.npc_data.npc_to_draw.size
	var drawxplus=200*change_mod
	var drawyplus=120*change_mod
	size+=size*change_mod
	
	var xx=npc_draw_x+drawxplus
	var yy=npc_draw_y+drawyplus
	
	var offsetx=sprite_get_xoffset(spr)
		var offsety=sprite_get_yoffset(spr)
		var down_coord_y=yy+size*(sprite_get_bbox_bottom(spr)-offsety)
		var up_coord_y=yy+size*(sprite_get_bbox_top(spr)-offsety)
		var down_coord_x=xx+size*(sprite_get_bbox_right(spr)-offsetx)
		var up_coord_x=xx+size*(sprite_get_bbox_left(spr)-offsetx)
	if point_in_rectangle(mouse_x,mouse_y,up_coord_x,up_coord_y,down_coord_x,down_coord_y)
		{
			sound_play_category_at(global.npc_data.npc_to_draw.sound,mouse_x,mouse_y)
		}


}


if hovering_offering_index!=-1 && mouse_check_button_pressed(mb_left)
{
	var item=global.npc_data.offerings[hovering_offering_index]
	var cost=item.cost_money
	if coins_buy_if_can(mouse_x,mouse_y,cost,true,2.5)
	{
		
		sound_play_category_at("buy",mouse_x,mouse_y)
		array_push(returning_items,item.item_id)
	
	}
	else{
		if coin_shake_meter==0
		{
			coin_shake_meter=720
			sound_play_category_at("buy_refuse",mouse_x,mouse_y)
		}
	}


}

global.npc_room_transfer_items=returning_items