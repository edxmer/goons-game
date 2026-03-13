image_alpha=0.2
var real_y=y-z
if selected
{
	image_alpha=0.6
	draw_nametag(name)
}
else if global.goon_edit_id==id
{
	image_alpha=1

}

draw_sprite_ext(equipment_sprite_draw,image_index,x,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(inventory_sprite,inventory_subimg,x,real_y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(equipment_sprite_draw,image_index,x,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha*1.2)
image_alpha=1