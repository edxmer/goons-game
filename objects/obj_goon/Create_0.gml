gooning=false
goon_speed=irandom_range(160,300) /3
goto_x=x
goto_y=y

distance_went=0
step_distance=goon_speed*0.3

inventory="empty"
inventory_sprite=spr_empty

interact_function=function()
{
	if inventory=="empty"{
		inventory=pickup_item(x,y)
		if inventory!="empty"{
			inventory_sprite=assign_item(inventory).texture
			sound_play_category_at("pickup",x,y)
		}
	}
	
}
