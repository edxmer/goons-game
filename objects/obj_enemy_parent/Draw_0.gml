depth=-bbox_bottom
if has_shadow
{
	draw_shadow()
}
if selected{
	depth=-room_height
	gpu_set_fog(true,c_white,0,0)
	draw_sprite_ext(sprite_index,image_index,x+1,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x-1,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y+1-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y-1-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	gpu_set_fog(false,c_white,0,0)
}

draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)


