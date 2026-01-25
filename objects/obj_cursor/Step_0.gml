if mouse_check_button_pressed(mb_left)
{
	var goons=0
	with(obj_goon){
		if gooning{
			goons++
		}
	}
	if goons==0{
		global.select_mode=true
		goons_selected=0
	}
	else{
		global.select_mode=false

					with(obj_goon){
						if gooning{
							var distance=point_distance(x,y,mouse_x,mouse_y)
							var bad_prec=min(distance*0.2,15)
							
							goto_x=clamp(mouse_x+irandom_range(-bad_prec,bad_prec),8,room_width-8)
							goto_y=clamp(mouse_y+irandom_range(-bad_prec,bad_prec),8,room_height-8)
							gooning=false
						}
					}
			

	}

}

if mouse_check_button(mb_left) && global.select_mode
{
	var gooned=0
	with(obj_goon){
		if position_meeting(mouse_x,mouse_y,id) && !gooning{
			gooning=true
			gooned++
		}
	}
	goons_selected+=gooned

}


if mouse_check_button_released(mb_left) && global.select_mode && goons_selected==0
{
	

}
