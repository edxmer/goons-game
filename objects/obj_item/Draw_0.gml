depth=-bbox_bottom

if useful{
depth-=70
}

image_xscale=size
image_yscale=size
var _x=show_x
var _y=show_y
draw_shadow(_x,_y+(bbox_bottom-y))
if useful{
	gpu_set_fog(true,#FFF45E,0,0)
	draw_sprite_ext(sprite_index,image_index,_x+1,_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,_x-1,_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,_x,_y+1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,_x,_y-1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	gpu_set_fog(false,#FFF45E,0,0)
}
draw_sprite_ext(sprite_index,image_index,_x,_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)