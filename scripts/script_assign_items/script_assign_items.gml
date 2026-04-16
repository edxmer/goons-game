/**
 * Creates item_structs from item_ids
 * @param {string} item_id The id of an item
 * @returns {struct} 
 */
function assign_item(item_id,staydata=[]){
	var item_data={staydata:[],texture:spr_empty,item_id:"empty",name:"empty",tags:[],ground_sound:"groundsoft",calories:0,particle_texture:spr_empty,held_texture:spr_empty,special_data:{}}
	item_data.item_id=item_id
	item_data.name=string_upper(string_copy(item_id,1,1))+ string_replace_all(string_copy(item_id,2,string_length(item_id)-1),"_"," ")
	array_push(item_data.tags,item_id)
	if string_copy(item_id,1,8)=="station_"{
		//station-woodcutter
		var _station_id=string_copy(item_id,9,string_length(item_id)-8)//(string_split(item_data,"-")[1])
		if workstation_tags_contain(_station_id,"donotbecomeitem")
		{
			return assign_item("empty")
		}
		item_data.name="Unbuilt "+work_station_data_get(_station_id).name
		item_data.texture=work_station_item_texture_get(_station_id)
		array_push(item_data.tags,"station")
		array_push(item_data.tags,"grid_mode")
		array_push(item_data.tags,"grid_mode_place_station")
		array_push(item_data.tags,"has_effects")
		array_push(item_data.tags,"weird_tag")
		array_push(item_data.tags,"building")
		array_push(item_data.tags,"put_down_on_grid")
		item_data.special_data.grid_mode_place_station_id=_station_id
		
		item_data.special_data.grid_mode_sprite=work_station_texture_get(_station_id)
		item_data.special_data.grid_mode_max_placeable=1
		item_data.special_data.grid_mode_placeable_function=function(xx,yy,sprite)
		{
			return gridmode_check_ground_hitboxes(xx,yy,sprite) && gridmode_check_workstation_hitboxes(xx,yy,sprite)
		}
	}
	if item_id=="*_seeds"{
		//item_data.texture=spr_turnip_seeds
		array_push(item_data.tags,"use_item")
		array_push(item_data.tags,"has_effects")
		array_push(item_data.tags,"plant")
		array_push(item_data.tags,"weird_tag")
		array_push(item_data.tags,"grid_mode")
		array_push(item_data.tags,"grid_mode_place_station")
		array_push(item_data.tags,"persistent")
		array_push(item_data.tags,"staydata_amount_lower_plant")
		item_data.staydata=[["amount",10]]
		
		//item_data.special_data.grid_mode_place_station_id="turnip_plant"
		//item_data.special_data.grid_mode_sprite=spr_grid_ui_turnip
		item_data.special_data.grid_mode_placeable_function=function(xx,yy,sprite)
		{
			return gridmode_check_ground_hitboxes_farmland_fromtop(xx,yy,sprite) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,sprite)
		}
	}
	if item_id=="turnip_seeds"{
		
		item_data=assign_item("*_seeds")
		array_push(item_data.tags,"turnip_seeds")
		array_push(item_data.tags,"nature")
		item_data.name=string_upper(string_copy(item_id,1,1))+ string_replace_all(string_copy(item_id,2,string_length(item_id)-1),"_"," ")
		item_data.texture=spr_turnip_seeds
		item_data.special_data.grid_mode_place_station_id="turnip_plant"
		item_data.special_data.grid_mode_sprite=spr_grid_ui_turnip
		item_data.calories=0
		item_data.staydata=[["amount",10]]
	}
	if item_id=="corn_seeds"{
		
		item_data=assign_item("*_seeds")
		array_push(item_data.tags,"corn_seeds")
		array_push(item_data.tags,"nature")
		item_data.staydata=[["amount",4]]
		item_data.name=string_upper(string_copy(item_id,1,1))+ string_replace_all(string_copy(item_id,2,string_length(item_id)-1),"_"," ")
		item_data.texture=spr_corn_seeds
		item_data.special_data.grid_mode_place_station_id="corn_plant"
		item_data.special_data.grid_mode_sprite=spr_grid_ui_corn
		item_data.calories=0

	}
	if item_id=="pineapple_seeds"{
		
		item_data=assign_item("*_seeds")
		array_push(item_data.tags,"pineapple_seeds")
		array_push(item_data.tags,"nature")
		item_data.staydata=[["amount",1]]
		item_data.name=string_upper(string_copy(item_id,1,1))+ string_replace_all(string_copy(item_id,2,string_length(item_id)-1),"_"," ")
		item_data.texture=spr_pineapple_seeds
		item_data.special_data.grid_mode_place_station_id="pineapple_plant"
		item_data.special_data.grid_mode_sprite=spr_ui_grid_pineapple
		item_data.calories=0

	}
	if item_id=="purple_mushroom_spores"{
		
		item_data=assign_item("*_seeds")
		array_push(item_data.tags,"purple_mushroom_spores")
		array_push(item_data.tags,"nature")
		item_data.staydata=[["amount",5]]
		item_data.name=string_upper(string_copy(item_id,1,1))+ string_replace_all(string_copy(item_id,2,string_length(item_id)-1),"_"," ")
		item_data.texture=spr_purple_mushroom_spores
		item_data.special_data.grid_mode_place_station_id="purple_mushroom_plant"
		item_data.special_data.grid_mode_sprite=spr_ui_grid_purple_mushroom
		item_data.calories=0
		item_data.special_data.grid_mode_placeable_function=function(xx,yy,sprite)
		{
			return gridmode_check_ground_hitboxes_dirty_fromtop(xx,yy,sprite) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,sprite)
		}

	}
	if item_id=="cat_tail_seeds"{
		
		item_data=assign_item("*_seeds")
		array_push(item_data.tags,"cat_tail_seeds")
		array_push(item_data.tags,"nature")
		item_data.staydata=[["amount",4]]
		item_data.name=string_upper(string_copy(item_id,1,1))+ string_replace_all(string_copy(item_id,2,string_length(item_id)-1),"_"," ")
		item_data.texture=spr_cattail_seeds
		item_data.special_data.grid_mode_place_station_id="cat_tail_plant"
		item_data.special_data.grid_mode_sprite=spr_ui_grid_cattail
		item_data.calories=0
		item_data.special_data.grid_mode_placeable_function=function(xx,yy,sprite)
		{
			return gridmode_check_ground_hitboxes_near_water_fromtop(xx,yy,sprite) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,sprite)
		}

	}
	if item_id=="elderberry_seeds"{
		
		item_data=assign_item("*_seeds")
		array_push(item_data.tags,"elderberry_seeds")
		array_push(item_data.tags,"nature")
		item_data.staydata=[["amount",1]]
		item_data.name=string_upper(string_copy(item_id,1,1))+ string_replace_all(string_copy(item_id,2,string_length(item_id)-1),"_"," ")
		item_data.texture=spr_elderberry_seeds
		item_data.special_data.grid_mode_place_station_id="elderberry_plant"
		item_data.special_data.grid_mode_sprite=spr_grid_ui_elderberry
		item_data.calories=0

	}
	if item_id=="corn_cob"{
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"vegetable")
		array_push(item_data.tags,"plant")
		item_data.texture=spr_corn_cob
		item_data.calories=15
	
	}
	if item_id=="pineapple"{
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"fruit")
		array_push(item_data.tags,"plant")
		item_data.texture=spr_ananas
		item_data.calories=190
	
	}
	if item_id=="cat_tail"{
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"plant")
		item_data.texture=spr_seadog
		item_data.calories=20
	
	}
	if item_id=="purple_mushroom"{
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"plant")
		item_data.texture=spr_titkos
		item_data.calories=40
		item_data.special_data.consume_effect=function(goon_id)
		{
			if booster_item_heal(goon_id,1)
			{
				sound_play_category_at("eat",goon_id.x,goon_id.y)
				goon_id.inventory_destroy()
			}
		}
	
	}
	if item_id=="elderberry"{
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"fruit")
		array_push(item_data.tags,"plant")
		item_data.texture=spr_elderberry
		item_data.calories=12
	
	}
	if item_id=="homonculus"{
		item_data.texture=spr_homonculus
		item_data.calories=40
		array_push(item_data.tags,"enemy")
		array_push(item_data.tags,"goo")
		item_data.special_data.enemy_data={turn_back:true,turn_after:1,turn_into:obj_enemy_homonculus}
	}
	if item_id=="corn_syrup"{
		item_data.ground_sound="groundglass"
		array_push(item_data.tags,"nature")
		item_data.texture=spr_corn_syrup
		item_data.calories=60
	
	}
	if item_id=="turnip"{
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"vegetable")
		array_push(item_data.tags,"plant")
		item_data.texture=spr_turnip
		item_data.calories=25
	
	}
	if item_id=="nature_juice"{
		item_data.ground_sound="groundglass"
			item_data.texture=spr_fruit_juice
		array_push(item_data.tags,"plant")
		array_push(item_data.tags,"consumable")
		array_push(item_data.tags,"health_boost")
		item_data.special_data.consume_effect=function(goon_id)
		{
			if booster_item_heal(goon_id,1)
			{
				sound_play_category_at("eat",goon_id.x,goon_id.y)
				goon_id.inventory_destroy()
			}
		}
		item_data.calories=4
	
	}
	if item_id=="pina_colada"{
		item_data.ground_sound="groundglass"
			item_data.texture=spr_pina_colada
		array_push(item_data.tags,"consumable")
		array_push(item_data.tags,"permanent_health_boost")
		item_data.special_data.consume_effect=function(goon_id)
		{
			if booster_item_increase_health(goon_id,8,8)
			{
				sound_play_category_at("eat",goon_id.x,goon_id.y)
				goon_id.inventory_destroy()
			}
		}
		item_data.calories=190
	
	}
	if item_id=="casserole"{
			item_data.texture=spr_casserole
		array_push(item_data.tags,"consumable")
		array_push(item_data.tags,"health_boost")
		item_data.special_data.consume_effect=function(goon_id)
		{
			if booster_item_heal(goon_id,3)
			{
				sound_play_category_at("eat",goon_id.x,goon_id.y)
				goon_id.inventory_destroy()
			}
		}
		item_data.calories=50
	
	}
	if item_id=="hot_dog"{
			item_data.texture=spr_hot_dog
		array_push(item_data.tags,"consumable")
		array_push(item_data.tags,"health_boost")
		item_data.special_data.consume_effect=function(goon_id)
		{
			if booster_item_heal(goon_id,8)
			{
				sound_play_category_at("eat",goon_id.x,goon_id.y)
				goon_id.inventory_destroy()
			}
		}
		item_data.calories=40
	
	}
	if item_id=="gummy_goon"{
			item_data.texture=spr_gummy_goon
		item_data.ground_sound="groundmedium"
		array_push(item_data.tags,"consumable")
		array_push(item_data.tags,"permanent_health_boost")
		item_data.special_data.consume_effect=function(goon_id)
		{
			if booster_item_increase_health(goon_id,1,8)
			{
				sound_play_category_at("eat",goon_id.x,goon_id.y)
				goon_id.inventory_destroy()
			}
		}
		item_data.calories=40
	
	}
	if item_id=="frozen_apple"{
			item_data.texture=spr_frozen_apple
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"consumable")
		array_push(item_data.tags,"blue")
		item_data.special_data.consume_effect=function(goon_id)
		{
			if !goon_id.dumb{
				goon_id.blue=true
			
				sound_play_category_at("eat",goon_id.x,goon_id.y)
				goon_id.inventory_destroy()
			}
		
		}
		item_data.calories=12
	
	}
	if item_id=="enchanted_apple"{
			item_data.texture=spr_enchanted_apple
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"consumable")
		array_push(item_data.tags,"witch")
		item_data.special_data.consume_effect=function(goon_id)
		{

			
			sound_play_category_at("eat",goon_id.x,goon_id.y)
			goon_id.inventory_destroy()
			create_work_station(goon_id.x,goon_id.y,"brewery")
			instance_destroy(goon_id)

		
		}
		item_data.calories=32
	
	}
	if item_id=="potion_of_mute"{
		item_data.name="Potion of Muting"
		item_data.ground_sound="groundglass"
			item_data.texture=spr_potion_of_mute
		array_push(item_data.tags,"consumable")
		item_data.special_data.consume_effect=function(goon_id)
		{
			goon_id.verboseness=0
			sound_play_category_at("eat",goon_id.x,goon_id.y)
			goon_id.inventory_destroy()
		
		}
		item_data.calories=7
	
	}
	
	if item_id=="potion_of_doom"{
		item_data.name="Potion of Doom"
		item_data.ground_sound="groundglass"
			item_data.texture=spr_potion_of_doom_2
		array_push(item_data.tags,"consumable")
		item_data.special_data.consume_effect=function(goon_id)
		{

			sound_play_category_at("eat",goon_id.x,goon_id.y)
			goon_id.inventory_destroy()
			goon_id.goon_die()
		
		}
		item_data.calories=7
	
	}
	if item_id=="logs"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_logs
		array_push(item_data.tags,"wood")
		item_data.calories=2
	
	}
	if item_id=="fly_hive"{
		item_data.texture=spr_fly_hive
		array_push(item_data.tags,"wood")
		item_data.calories=27
	
	}
	if item_id=="frog"{
		item_data.texture=spr_frog
		array_push(item_data.tags,"animal")
		item_data.calories=30
	}
	if item_id=="candy"{
		item_data.texture=spr_candy
		array_push(item_data.tags,"crafted")
		item_data.calories=45
		item_data.special_data.consume_effect=function(goon_id)
		{
			if booster_item_heal(goon_id,1)
			{
				sound_play_category_at("eat",goon_id.x,goon_id.y)
				goon_id.inventory_destroy()
			}
		}
	}
	if item_id=="antlers"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_noog_antlers
		array_push(item_data.tags,"equippable")
		item_data.special_data.equipped_sprites=[spr_wear_antlers_idle,spr_wear_antlers_walk]
	}
	if item_id=="strawhat"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_farmer_hat
		array_push(item_data.tags,"equippable")
		item_data.special_data.equipped_sprites=[spr_wear_farmer_hat_idle,spr_wear_farmer_hat_walk]
	}
	if item_id=="constructors_belt"{
		
		item_data.name="Constructor's Belt"
		item_data.texture=spr_constructors_belt
		array_push(item_data.tags,"eq_pick_up_building")
		array_push(item_data.tags,"eq_has_effects")
		array_push(item_data.tags,"equippable")
		array_push(item_data.tags,"eq_weird_tag")
		item_data.special_data.equipped_sprites=[spr_wear_constructors_belt_idle,spr_wear_constructors_belt_walk]
	}
	if item_id=="ball_and_chain"{
		item_data.ground_sound="groundmedium"
		item_data.name="Ball & Chain"
		item_data.texture=spr_ball_and_chain
		array_push(item_data.tags,"eq_robot")
		array_push(item_data.tags,"eq_slowed")
		array_push(item_data.tags,"eq_has_effects")
		array_push(item_data.tags,"equippable")
		array_push(item_data.tags,"eq_weird_tag")
		item_data.special_data.slow_percentage=0.1
		item_data.special_data.equipped_sprites=[spr_wear_ball_and_chain_idle,spr_wear_ball_and_chain_walk]
	}
	if item_id=="snow_globe"{
		item_data.ground_sound="groundmedium"
		item_data.name="Snow Globe"
		item_data.texture=spr_snow_globe
		array_push(item_data.tags,"eq_place_snow")
		array_push(item_data.tags,"eq_has_effects")
		array_push(item_data.tags,"equippable")
		item_data.special_data.equipped_sprites=[spr_wear_snow_globe_idle,spr_wear_snow_globe_walk]
	}
	if item_id=="ice_cream"{
		item_data.texture=spr_ice_cream
		item_data.special_data.freezing_pixel_amount=200
		array_push(item_data.tags,"freezing")
		array_push(item_data.tags,"has_effects")
		array_push(item_data.tags,"danger")
		item_data.calories=120
	}
	if item_id=="froglamp"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_froglamp
		array_push(item_data.tags,"crafted")
		item_data.calories=60
	}
	if item_id=="plank"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_plank
	array_push(item_data.tags,"wood")
		array_push(item_data.tags,"crafted")
		item_data.calories=3
	}
	if item_id=="lamp"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_lamp
		array_push(item_data.tags,"crafted")
		item_data.calories=20
	}
	if item_id=="hammer"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_hammer
		array_push(item_data.tags,"pick_up_building")
		array_push(item_data.tags,"has_effects")
		array_push(item_data.tags,"weird_tag")
		//array_push(item_data.tags,"persistent")
	}
	if item_id=="lance"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_lance
		array_push(item_data.tags,"use_item")
		array_push(item_data.tags,"create_hurt")
		array_push(item_data.tags,"has_effects")
		array_push(item_data.tags,"weapon")
		item_data.special_data.hurt_object=obj_hurtbbox_stab_1
		item_data.special_data.hurt_damage_base=3
		item_data.special_data.hurt_size=2
		
	}
	if item_id=="sickle"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_sickle
		array_push(item_data.tags,"use_item")
		array_push(item_data.tags,"create_hurt")
		array_push(item_data.tags,"has_effects")
		array_push(item_data.tags,"weapon")
		item_data.special_data.hurt_object=obj_hurtbbox_slash_1
		item_data.special_data.hurt_damage_base=2
		item_data.special_data.hurt_size=1.2
		
	}
	if item_id=="hoe"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_hoe
		array_push(item_data.tags,"use_item")
		array_push(item_data.tags,"tilt_ground")
		array_push(item_data.tags,"has_effects")
		array_push(item_data.tags,"grid_mode")
		array_push(item_data.tags,"persistent")
		array_push(item_data.tags,"persistent_brewery")
		array_push(item_data.tags,"weird_tag")
		item_data.special_data.grid_mode_sprite=spr_grid_ui_tilted_ground
		item_data.special_data.grid_mode_placeable_function=function(xx,yy,sprite)
		{
			return gridmode_check_ground_hitboxes_fromtop(xx,yy,sprite) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,sprite)
		}
	}
	else if item_id=="wloob_confused"{
		item_data.ground_sound="whimper"
		item_data.name="Confused Wloob"
		item_data.special_data.enemy_data={turn_back:true,turn_after:5,turn_into:obj_enemy_wloob}
		item_data.texture=spr_wloob_confused
		item_data.held_texture=spr_wloob_caught
		item_data.particle_texture=spr_wloob_particle
		array_push(item_data.tags,"enemy")
		item_data.calories=16
	}
	if item_id=="goon_blue"{
		item_data.texture=spr_goon_blue
		array_push(item_data.tags,"unpickuppable")
	}
	if item_id=="goon_show_dumb"{
		item_data.texture=spr_goon_dumb
		array_push(item_data.tags,"unpickuppable")
	}
	else if item_id=="cigarette"{
		item_data.texture=spr_cigarette
		array_push(item_data.tags,"crafted")
		item_data.calories=10
	}
	else if item_id=="rock"{
		item_data.ground_sound="groundmedium"
		item_data.texture=spr_rock
		array_push(item_data.tags,"stone")
		item_data.calories=1
	}
	else if item_id=="banana"{
		item_data.texture=spr_banana
		array_push(item_data.tags,"nature")
		array_push(item_data.tags,"trash")
		array_push(item_data.tags,"plant")
		item_data.calories=3
	}
	else if item_id=="goo"{
		item_data.texture=spr_goo_yellow
		array_push(item_data.tags,"crafted")
		array_push(item_data.tags,"*_goo")
	}
	else if item_id=="wloob_goo"{
		item_data.texture=spr_goo_wloob
		array_push(item_data.tags,"*_goo")
	}
	else if item_id=="goon_show"{
		item_data.texture=spr_goon
		array_push(item_data.tags,"unpickuppable")
	}
	else if item_id=="goon_show_blue"{
		item_data.texture=spr_goon_blue
		array_push(item_data.tags,"unpickuppable")
	}
	else if item_id=="reward"{
		item_data.texture=spr_reward
		array_push(item_data.tags,"unpickuppable")
	}
	else if item_id=="sock"{
		item_data.texture=spr_sock
		array_push(item_data.tags,"container")
		array_push(item_data.tags,"trash")
		item_data.calories=1
	}
	
	
	
	
	
	if item_data.held_texture==spr_empty
	{
		item_data.held_texture=item_data.texture
	}
	
	if item_data.particle_texture==spr_empty
	{
		item_data.particle_texture=item_data.texture
	}
	
	if array_length(staydata)!=0
	{
		item_data.staydata=staydata
	}
	return item_data
}