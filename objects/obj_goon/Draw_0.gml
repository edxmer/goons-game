depth=-bbox_bottom
draw_shadow()

image_alpha=1

if gooning{
	depth-=100
	gpu_set_fog(true,c_white,0,0)
	draw_sprite_ext(sprite_index,image_index,x+1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x-1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y+1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y-1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	if equipment!="empty"
	{
		draw_sprite_ext(equipment_sprite_draw,image_index,x+1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(equipment_sprite_draw,image_index,x-1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(equipment_sprite_draw,image_index,x,y-1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(equipment_sprite_draw,image_index,x,y+1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	}
	if inventory!="empty"{
		draw_sprite_ext(inventory_sprite,image_index,x+1,y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(inventory_sprite,image_index,x-1,y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(inventory_sprite,image_index,x,y-11,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		draw_sprite_ext(inventory_sprite,image_index,x,y-13,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
		
	}

	gpu_set_fog(false,c_white,0,0)
}
draw_self()
if equipment!="empty"{

	draw_sprite_ext(equipment_sprite_draw,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

if inventory!="empty"{

	draw_sprite_ext(inventory_sprite,0,x,y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}