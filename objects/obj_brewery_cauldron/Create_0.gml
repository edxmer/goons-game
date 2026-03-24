scale=1
dropped_x=x
dropped_y=y
dropped_time=current_time
splash=false
current_potion="empty"
array_push(global.npc_room_transfer_items,"empty")
current_item_index=array_length(global.npc_room_transfer_items)-1

potion_show_size=0

current_contents=[]

reset_potion_color=function()
{
	potion_color=[ #828DED, #7FEA75, #E86FAD][irandom(2)]
}
reset_potion_color()
current_value=0


potion_step=0
potion_item="empty"

audio_play_sound(sound_ambience_cauldron,0.5,1)

change_transfer_item=function(change_to_item_id)
{
	global.npc_room_transfer_items[current_item_index]=change_to_item_id

}

ship_current_item=function()
{
	current_value=0
	reset_potion_color()
	current_contents=[]
	var curr_potion=instance_create_depth(mouse_x,mouse_y,0,obj_brewery_item)
	curr_potion.item_id=array_last(global.npc_room_transfer_items)
	
	array_push(global.npc_room_transfer_items,"empty")
	current_potion="empty"
	current_item_index=array_length(global.npc_room_transfer_items)-1
}

drop_item=function(item_id)
{	

	current_contents=current_ingredients_push(current_contents,item_id)
	var changed=ingredients_evaluate(current_contents,current_value,current_potion,potion_color)
	if changed.brew_into!=current_potion
	{
		know_new_recipe(changed.name)
		new_potion_turn_into(changed)
	}
	if current_potion!="empty" && !instance_exists(obj_button_brewery_brew)
	{
		potion_show_size=0
		instance_create_layer(bbox_right+200,bbox_bottom+100,layer,obj_button_brewery_brew)
	}

}

new_potion_turn_into=function(changed)
{
	current_potion=changed.brew_into
	current_value=changed.value 
	potion_color=changed.color 
	change_transfer_item(current_potion)

}

