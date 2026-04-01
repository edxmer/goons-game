image_xscale=size
image_yscale=size


if recipe_down
{

}
else
{
		var yy=-(board_y)%(34*size)
	for (var i=0;i<ceil(abs(board_y-0)/(34*size));i++)
	{
		draw_sprite_ext(spr_brewery_recipe_board_part,0,x,yy,size,size,0,c_white,1)
		yy+=34*size
	}
	draw_sprite_ext(spr_brewery_recipe_board_basic,0,x,yy,size,size,0,c_white,1)
	
	

	draw_self()
	if global.npc_brewery_new_recipe
	{
		draw_sprite_ext(spr_brewery_recipe_board_exclamation,sprite_get_current_subimg(spr_brewery_recipe_board_exclamation),x,y,size,size,0,c_white,1)
	}
}
