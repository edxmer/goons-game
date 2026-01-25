size=0.1

sprite_index=spr_empty
item_id="empty"
assigned=false
assign=function(){
	assigned=true
	if item_id=="empty"
	{
		instance_destroy()
	}
	var item_data=assign_item(item_id)
	sprite_index=item_data.texture
	if sprite_index==spr_empty
	{
		instance_destroy()
	}

}

