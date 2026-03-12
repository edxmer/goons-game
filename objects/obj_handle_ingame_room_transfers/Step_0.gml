if global.save_the_game
{
	create_save(global.open_save_name)
	global.save_the_game=false
	if global.exit_to_main_menu
	{
		room_persistent = false
		global.exit_to_main_menu=false
		room_goto(room_main_menu)
	}
	
}

var npc_forget=false
if array_length(global.npc_room_transfer_items_to_destroy)>0
{
	with(global.npc_room_workstation_id)
	{
		for (var i=0;i<array_length(global.npc_room_transfer_items_to_destroy);i++)
		{
			var item_to_destroy=global.npc_room_transfer_items_to_destroy[i]
			item_destroy_nearby(item_to_destroy)
		}
	}
	global.npc_room_transfer_items_to_destroy=[]
	npc_forget=true
}


if array_length(global.npc_room_transfer_items)>0
{
	with(global.npc_room_workstation_id)
	{
		for (var i=0;i<array_length(global.npc_room_transfer_items);i++)
		{
			var item_id=global.npc_room_transfer_items[i]
			summon_item_from_pool([item_id])
		
		}
	
	}
	global.npc_room_transfer_items=[]
	npc_forget=true
 
}


if npc_forget
{

	global.npc_room_workstation_id=noone
}