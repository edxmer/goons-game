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
	}
	else{
		global.select_mode=false

					with(obj_goon){
						if gooning{
							goto_x=mouse_x+irandom_range(-15,15)
							goto_y=mouse_y+irandom_range(-15,15)
							gooning=false
						}
					}
			

	}

}

if mouse_check_button(mb_left) && global.select_mode
{
	with(obj_goon){
		if position_meeting(mouse_x,mouse_y,id){
			gooning=true
		}
	}

}



