depth=-bbox_bottom
draw_shadow()

image_alpha=1
var real_y=y-z
if gooning{
	depth-=100
	gpu_set_fog(true,c_white,0,0)
	draw_sprite_ext(sprite_index,image_index,x+1,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x-1,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,real_y+1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,real_y-1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	if equipment!="empty"
	{
		draw_sprite_ext(equipment_sprite_draw,image_index,x+1,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(equipment_sprite_draw,image_index,x-1,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(equipment_sprite_draw,image_index,x,real_y-1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(equipment_sprite_draw,image_index,x,real_y+1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	}
	if inventory!="empty"{
		draw_sprite_ext(inventory_sprite,inventory_subimg,x+1,real_y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(inventory_sprite,inventory_subimg,x-1,real_y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(inventory_sprite,inventory_subimg,x,real_y-11,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(inventory_sprite,inventory_subimg,x,real_y-13,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		
	}

	gpu_set_fog(false,c_white,0,0)
}
draw_sprite_ext(sprite_index,image_index,x,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if equipment!="empty"{

	draw_sprite_ext(equipment_sprite_draw,image_index,x,real_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

if inventory!="empty"{

	draw_sprite_ext(inventory_sprite,inventory_subimg,x,real_y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}