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
			y-=17*size
			if y<=-16
			{
				instance_destroy()
			}
		}
		
	
	}


}
else
{
	if board_y<34*size*3
	{
		board_y+=17*size
	}
	
	
	if onmouse
	{
		sprite_index=spr_brewery_recipe_board_backward_onmouse
	}
	else
	{
		sprite_index=spr_brewery_recipe_board_backward_onmouse
	}


}