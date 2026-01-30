image_alpha=0.2
if point_in_rectangle(mouse_x,mouse_y,bbox_left,bbox_top,bbox_right,bbox_bottom)
{
	image_alpha=0.6
}
draw_self()
draw_sprite_ext(inventory_sprite,0,x,y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
image_alpha=1