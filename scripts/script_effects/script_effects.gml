function effect_update(goon_id)
{
	effect_set_base(goon_id)
	item_set_effects(goon_id,goon_id.inventory,"")
	if item_tags_contains(goon_id.equipment,"eq_has_effects")
	{
		item_set_effects(goon_id,goon_id.equipment,"eq_")
	}
}

function effect_init(goon_id)
{
	effect_set_base(goon_id)
	goon_id.effect_data_stay={freezing:{freezing_pixel_taken:0},use_item:{started_with_effect:false}}
}


function effect_set_base(goon_id)
{
	if goon_id.object_index==obj_goon{
		goon_id.slowness_modifier=1
		goon_id.has_effects=false
		goon_id.effects={freezing:{is:false,freezing_pixel_amount:0},slowed:{is:false,slow_percentage:1},pick_up_building:{is:false},use_item:{is:false},place_snow:{is:false},tilt_ground:{is:false},grid_mode:{is:false,ui_sprite:spr_empty,max_placeable:-1},grid_mode_place_item:{is:false}}
		
	}
}


function item_set_effects(goon_id,item_id,prefix){
	if array_contains(item_get_tags(item_id),prefix+"has_effects")
	{
		var real_effects=false
		var next_effect="freezing"
		if array_contains(item_get_tags(item_id),prefix+next_effect) && item_special_data_contains(item_id,prefix+"freezing_pixel_amount")
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"freezing_pixel_amount",item_special_data_get(item_id,"freezing_pixel_amount"))
			real_effects=true
		}
		
		next_effect="slowed"
		if array_contains(item_get_tags(item_id),prefix+next_effect) && item_special_data_contains(item_id,prefix+"slow_percentage")
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"slow_percentage",item_special_data_get(item_id,"slow_percentage"))
			slowness_modifier*=item_special_data_get(item_id,"slow_percentage")
			real_effects=true
		}
		
		next_effect="pick_up_building"
		if array_contains(item_get_tags(item_id),prefix+next_effect)
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			real_effects=true
		}
		next_effect="place_snow"
		if array_contains(item_get_tags(item_id),prefix+next_effect)
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			real_effects=true
		}
		next_effect="grid_mode_place_item"
		if array_contains(item_get_tags(item_id),prefix+next_effect)
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			real_effects=true
		}
		next_effect="tilt_ground"
		if array_contains(item_get_tags(item_id),prefix+next_effect)
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			real_effects=true
		}
		next_effect="use_item"
		if array_contains(item_get_tags(item_id),prefix+next_effect)
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			real_effects=true
		}

		next_effect="grid_mode"
		if array_contains(item_get_tags(item_id),prefix+next_effect)
		{
			
			variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"is",true)
			if item_special_data_get(item_id,"grid_mode_sprite")!="empty"
			{
				variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"ui_sprite",item_special_data_get(item_id,"grid_mode_sprite"))
			}
			if item_special_data_get(item_id,"grid_mode_max_placeable")!="empty"
			{
				variable_struct_set( variable_struct_get(goon_id.effects,next_effect),"max_placeable",item_special_data_get(item_id,"grid_mode_max_placeable"))
			}
			real_effects=true
		}
		goon_id.has_effects=real_effects
	}
}


function effect_tick(goon_id)
{
	
	if goon_id.has_effects
	{
		if goon_id.effects.use_item.is{
			if goon_id.got_new_directions
			{
				
				goon_id.effect_data_stay.use_item.started_with_effect=true
			}
			if goon_id.reached_destination_this_frame && goon_id.effect_data_stay.use_item.started_with_effect
			{
				
				use_item=true
			}
		}
		else if goon_id.effect_data_stay.use_item.started_with_effect
		{
			goon_id.effect_data_stay.use_item.started_with_effect=false
		}
		
		if goon_id.effects.grid_mode.is
		{

			if goon_id.only_this_goon_gooning()
			{
				global.should_be_gridmode=true
				global.grid_mode_sprite=goon_id.effects.grid_mode.ui_sprite
				global.grid_mode_max_points_of_interests=goon_id.effects.grid_mode.max_placeable
				
			}
		
		
		}
		if goon_id.effects.grid_mode_place_item.is
		{

			if goon_id.gridmode_use_item
			{
				goon_id.put_down_item()
				
			}
		
		
		}

		if goon_id.effects.freezing.is{
			goon_id.effect_data_stay.freezing.freezing_pixel_taken+=goon_id.pixels_taken_this_frame
			if goon_id.effect_data_stay.freezing.freezing_pixel_taken>=goon_id.effects.freezing.freezing_pixel_amount
			{
				sound_play_category_at("freeze",x,y)
				var ice=create_work_station(x,y,"frozen_goon")
				ice.has_special_crafting_output=true
				ice.special_crafting_output=[goon_id.item_type]
				ice.crafting_reward_pool=[goon_id.item_type]
				instance_destroy(goon_id)
				return
				
			}
		}

		
		if goon_id.effects.pick_up_building.is{
			if reached_destination_this_frame{
				var wst_id=noone
				with(goon_id){wst_id=workstation_nearby_accepst_my_item(true)}
				if wst_id!=noone{
					if item_tags_contains(goon_id.inventory,"persistent") || item_tags_contains(goon_id.equipment,"eq_pick_up_building")
					{
						with(goon_id){put_down_item()}
					}
					else
					{
						item_id_summon_particles(goon_id.inventory,goon_id.x,goon_id.y)
					}
					var sound=work_station_use_sound_get(wst_id.station_id)
					sound_play_category_at(sound,x,y)
					sound_play_category_at("stonework",x,y)
					var item_id=workstation_turn_to_item(wst_id)
					goon_pickup_item(item_id,true)
				}
				
			}
		
		}
		if goon_id.effects.place_snow.is
		{
			var diff=5
			set_tilemap_snow((goon_id.x+diff)>>4,(goon_id.bbox_bottom+diff)>>4)
			set_tilemap_snow((goon_id.x-diff)>>4,(goon_id.bbox_bottom+diff)>>4)
			set_tilemap_snow((goon_id.x-diff)>>4,(goon_id.bbox_bottom-diff)>>4)
			set_tilemap_snow((goon_id.x+diff)>>4,(goon_id.bbox_bottom-diff)>>4)
			set_tilemap_snow(goon_id.x>>4,goon_id.bbox_bottom>>4)
		}
		if goon_id.effects.tilt_ground.is
		{
			if goon_id.use_item
			{
				if set_tilemap_farmland(goon_id.x>>4,goon_id.bbox_bottom>>4)
				{
					if !item_tags_contains(goon_id.inventory,"persistent") && !item_tags_contains(goon_id.equipment,"eq_tilt_ground")
					{
						item_id_summon_particles(goon_id.inventory,x,y)
						with(goon_id){inventory_set_empty()}
					}
				}
			}
		}

	
	}

}