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



function npc_create_object_base()
{
	var empty={obj:obj_item,x:0,y:0}
	return empty
}
function npc_create_object(obj,xx,yy)
{
	var ret=npc_create_object_base()
	ret.obj=obj
	ret.x=xx
	ret.y=yy
	return ret
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
		room_tiles_below:[npc_create_room_tile_data_base()],
		returning_items_show:npc_get_base_item_show_struct(),
		nearby_items_show:npc_get_base_item_show_struct(),
		active_quests_show:{show:false,topleft_coord:[0,0],size:2},
		active_quests:[],
		summoned_objects:[]
		
		
		}
	return data

}

function npc_get_base_item_show_struct()
{
	var array={show:false,startx:0,starty:0,spacingx:0,spacingy:0,size:1,shadow:true,clampx:-1,clampy:-1}
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
	var draw_again=[false,"empty",0,0]
	for (var i=0;i<array_length(item_datas);i++)
	{
		if do_outline
		{

			if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),startx-8*size,starty-8*size,startx+8*size,starty+8*size)
			{
				
				out=item_datas[i]
				done_outline=true
				draw_again=[true,out,startx,starty]

			}
		}
		draw_item(startx,starty,item_datas[i],size,1,shadow,true)
		startx+=spacingx
		starty+=spacingy
		if dt.clampx>=0
		{
			if startx>=dt.clampx+dt.startx
			{
				startx=dt.startx
			}
		}
		if dt.clampy>=0
		{
			if startx>=dt.clampy+dt.starty
			{
				starty=dt.starty
			}
		}
	}
	if draw_again[0]
	{
		startx=draw_again[2]
		starty=draw_again[3]
		var itid=draw_again[1]
		gpu_set_fog(true,c_white,0,0)
		draw_item(startx+1*size,starty,itid,size,1,false,true)
		draw_item(startx-1*size,starty,itid,size,1,false,true)
		draw_item(startx,starty+1*size,itid,size,1,false,true)
		draw_item(startx,starty-1*size,itid,size,1,false,true)
		gpu_set_fog(false,c_white,0,0)
		draw_item(startx,starty,itid,size,1,false,true)
	}
	return out

}