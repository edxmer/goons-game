depth=-bbox_bottom

if useful{
depth-=20
}

image_xscale=size
image_yscale=size
draw_shadow()
if useful{
	gpu_set_fog(true,#FFF45E,0,0)
	draw_sprite_ext(sprite_index,image_index,x+1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x-1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y+1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y-1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	gpu_set_fog(false,#FFF45E,0,0)
}
draw_self()