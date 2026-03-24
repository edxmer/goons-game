if point_in_rectangle(mouse_x,mouse_y,bbox_left,bbox_top,bbox_right,bbox_bottom)
{
	if !onmouse
	{
		sound_play_category_at("swoosh",x,y)
	}
	onmouse=true
}
else
{
	if onmouse
	{
		sound_play_category_at("swoosh",x,y)
	}
	onmouse=false
}


if !recipe_down
{

	if board_y>0
	{
		board_y-=17*size
	}
	if onmouse
	{
		sprite_index=spr_brewery_recipe_board_onmouse
	}
	else
	{
		sprite_index=spr_brewery_recipe_board
	}
	
	
	if (instance_exists(obj_brewery_recipe))
	{
		with(obj_brewery_recipe)
		{
			y_real-=17*size
			if y_real<=-16
			{
				instance_destroy()
			}
		}
		
	
	}
	if mouse_wheel_down()
	{
		board_down()
	}

}
else
{
	if board_y<board_y_max
	{
		board_y+=17*size
		with(obj_brewery_recipe)
		{
			y_real+=17*size
		}
	}
	else if board_y>board_y_max
	{
		board_y-=17*size
		with(obj_brewery_recipe)
		{
			y_real-=17*size
		}
	}
	with(obj_brewery_item)
	{
		if point_in_rectangle(x,y,other.bbox_left,0,other.bbox_right,other.board_y+70)
		{
			show_data=false
		}
	}
	if point_in_rectangle(mouse_x,mouse_y,other.bbox_left,0,other.bbox_right,other.board_y+70)
	{
		if mouse_check_button_pressed(mb_left)
		{
			var dothat=true
			with(obj_brewery_recipe)
			{
				if on_mouse
				{
				sound_play_category_at("paper",x,y)
					dothat=false
					with(obj_brewery_item)
					{
						held=false
					}
				}
			}
			if dothat{
				sound_play_category_at("groundmedium",x,y)
			board_held=true
			last_mouse_y=mouse_y
			}
		}

		
	}
	if board_held
	{
		if !mouse_check_button(mb_left)
		{
			board_held=false
		}
		else
		{
			with(obj_brewery_item)
			{
				held=false
			}
			if abs(last_mouse_y-mouse_y)>=5*size
			{
				board_y_max+=sign(-last_mouse_y+mouse_y)*17*size
				if board_y_max<=calc_max_y()
				{
					sound_play_category_at("groundmedium",x,y)
					last_mouse_y=mouse_y
				}
				else
				{
					last_mouse_y=mouse_y+1*size
				}
				board_y_max=min(board_y_max,calc_max_y())
				
				
			}
		}
	
	}
	
	if onmouse
	{
		sprite_index=spr_brewery_recipe_board_backward
	}
	else
	{
		sprite_index=spr_brewery_recipe_board_backward_onmouse
	}

	if mouse_wheel_up()
	{
		sound_play_category_at("groundmedium",x,y)
		board_y_max-=17*size
	}
		if mouse_wheel_down()
	{
		board_y_max+=17*size
		if  board_y_max<=calc_max_y()
		{
			sound_play_category_at("groundmedium",x,y)
		}
		board_y_max=min(board_y_max,calc_max_y())
	}
	if board_y_max<34*size
	{
		board_up()
	}
}