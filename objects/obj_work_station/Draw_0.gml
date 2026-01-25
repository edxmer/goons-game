depth=-bbox_bottom

if selected{
	gpu_set_fog(true,c_white,0,0)
	draw_sprite_ext(sprite_index,image_index,x+1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x-1,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y+1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y-1,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	gpu_set_fog(false,c_white,0,0)
	
	if crafting{
		if spawning{
			draw_both_information(x-30,y-40,crafting_input_ids,crafting_reward_pool,spawn_item_pool)
		}
		else{
			draw_craft_information(x-30,y-40,crafting_input_ids,crafting_reward_pool)
		}
	}
	else if spawning
	{
			draw_summon_information (x-30,y-40,spawn_item_pool)
		
	}


}

draw_self()