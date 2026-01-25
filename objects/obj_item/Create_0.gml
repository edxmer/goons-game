size=0.1

useful=false

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

useful_function=function()
{
	var _x=x
	var _y=y
	var item=item_id
	with(obj_work_station)
	{
		var x_min=bbox_left-20
		var x_max=bbox_right+20
		var y_min=bbox_top-10
		var y_max=bbox_bottom+20
		if point_in_rectangle(_x,_y,x_min,y_min,x_max,y_max)
		{
			if array_contains(crafting_input_ids,item)
			{
				return true
			}
		
		}
	
	}
	return false



}