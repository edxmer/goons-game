function effect_update(goon_id)
{
	effect_set_base(goon_id)
	item_set_effects(goon_id,goon_id.inventory)
}

function effect_init(goon_id)
{
	effect_set_base(goon_id)
	goon_id.effect_data_stay={freezing:{freezing_pixel_taken:0}}
}


function effect_set_base(goon_id)
{
	if goon_id.object_index==obj_goon{
		goon_id.slowness_modifier=1
		goon_id.has_effects=false
		goon_id.effects={freezing:{is:false,freezing_pixel_amount:0},slowed:{is:false,slow_percentage:1}}
	}
}


function item_set_effects(goon_id,item_id){
	if array_contains(item_get_tags(item_id),"has_effects")
	{
		var real_effects=false
		var next_effect="freezing"
		if array_contains(item_get_tags(item_id),next_effect) && item_special_data_contains(item_id,"freezing_pixel_amount")
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"freezing_pixel_amount",item_special_data_get(item_id,"freezing_pixel_amount"))
			real_effects=true
		}
		
		next_effect="slowed"
		if array_contains(item_get_tags(item_id),next_effect) && item_special_data_contains(item_id,"slow_percentage")
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"slow_percentage",item_special_data_get(item_id,"slow_percentage"))
			slowness_modifier*=item_special_data_get(item_id,"slow_percentage")
			real_effects=true
		}
		
		goon_id.has_effects=real_effects
	}
}


function effect_tick(goon_id)
{
	if goon_id.has_effects
	{
		if goon_id.effects.freezing.is{
			goon_id.effect_data_stay.freezing.freezing_pixel_taken+=goon_id.pixels_taken_this_frame
			if goon_id.effect_data_stay.freezing.freezing_pixel_taken>=goon_id.effects.freezing.freezing_pixel_amount
			{
				sound_play_category_at("freeze",x,y)
				var ice=create_work_station(x,y,"frozen_goon")
				ice.has_special_crafting_output=true
				ice.special_crafting_output=[goon_id.item_type]
				ice.crafting_reward_pool=[goon_id.item_type]
				instance_destroy()
				
			}
		}
	
	
	}

}