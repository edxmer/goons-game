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
		returning_items_show:{show:true,startx:0,starty:0,spacingx:0,spacingy:0,size:1,shadow:true}
		
		}
	return data

}