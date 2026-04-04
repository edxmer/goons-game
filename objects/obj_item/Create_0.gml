size=0.1

grew_up=false

selected=false

name=""

useful=false

put_down_by_goon=false

tags=[]

turn_into_object=false
turn_into=obj_item
turn_after=0

sprite_index=spr_empty
item_id="empty"
item_stay_data=[]
assigned=false
assign=function(){
	assigned=true
	if item_id=="empty"
	{
		instance_destroy()
	}
	var item_data=assign_item(item_id,item_stay_data)
	if array_length(item_stay_data)==0
	{
		item_stay_data=item_data.staydata
	}
	sprite_index=item_data.texture
	tags=item_data.tags
	
	if array_contains(tags,"enemy")
	{
		if item_special_data_contains(item_id,"enemy_data")
		{
			var enemy_data=item_special_data_get(item_id,"enemy_data")
			if variable_instance_exists(enemy_data,"turn_back") && enemy_data.turn_back
			{
				turn_into_object=true
				turn_after=enemy_data.turn_after 
				turn_into=enemy_data.turn_into
				
			}
		}
	}
	name=item_data.name
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