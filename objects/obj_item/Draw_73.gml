if selected {
	gpu_set_fog(true,c_white,0,0)
	if useful{
	gpu_set_fog(true,#FFF45E,0,0)
	}
	draw_sprite_ext(sprite_index,image_index,x+1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x-1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y+1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y-1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	gpu_set_fog(false,c_white,0,0)
	if useful{
	gpu_set_fog(false,#FFF45E,0,0)
	}

	draw_self()
	draw_nametag(name)
}