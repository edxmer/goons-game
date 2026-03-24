
board_y_smooth=round((board_y*0.8+board_y_smooth*0.2))

if board_y_smooth>0
{
	var yy=-((board_y_smooth)%(34*size))
	for (var i=0;i<ceil(abs(board_y)/(34*size));i++)
	{
		draw_sprite_ext(spr_brewery_recipe_board_part,0,x,yy,size,size,0,c_white,1)
		yy+=34*size
	}
	draw_sprite_ext(spr_brewery_recipe_board_basic,0,x,yy,size,size,0,c_white,1)
	draw_self()
}