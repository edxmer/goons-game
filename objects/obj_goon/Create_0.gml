gooning=false
goon_speed=irandom_range(6,9) /3
goto_x=x
goto_y=y

inventory="empty"
inventory_sprite=spr_empty

interact_function=function()
{
	if inventory=="empty"{
		inventory=pickup_item(x,y)
		if inventory!="empty"{
			inventory_sprite=assign_item(inventory).texture
		}
	}
	
}
