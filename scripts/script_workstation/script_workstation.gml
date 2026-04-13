function draw_workstation(_x,_y,station_id,scale)
{
	var sprite=work_station_data_get(station_id).texture
	draw_sprite_ext(sprite,0,_x,_y,scale,scale,0,c_white,1)

}

function workstation_interactable_nearby(xx,yy,boolmode=true)
{
	var idlist=[]
	with(obj_work_station)
	{
		var x_min=bbox_left-20
		var x_max=bbox_right+20
		var y_min=bbox_top-10
		var y_max=bbox_bottom+20
		if point_in_rectangle(xx,yy,x_min,y_min,x_max,y_max) && can_be_interacted
		{
			if boolmode
			{
				return true
			}
			else
			{
				array_push(idlist,id)
			}
		}
	}
	if boolmode
	{
		return false
	}
	else
	{
		return idlist
	}
}


function workstation_selected_id()
{
	with(obj_work_station)
	{
		if selected{
			return id
		}
	}
	return noone

}
function workstation_id_summon_particles(work_station_id,xx,yy)
{
	particle_summon_from_texture_multiple(xx,yy,work_station_texture_get(work_station_id),irandom_range(12,15))
}
function workstation_get_craftable_items()
{
	var itemslist=[]
	with(obj_work_station)
	{
		for(var i=0;i<array_length(crafting_reward_pool);i++)
		{
			if crafting_reward_pool[i]!="goon_show" && crafting_reward_pool[i]!="reward"&& crafting_reward_pool[i]!="goon_blue"{
				array_push(itemslist,crafting_reward_pool[i])
				array_push(itemslist,crafting_reward_pool[i])
				if onemore_chance{
					array_push(itemslist,crafting_reward_pool[i])
				}
			}
		}
	}
	return itemslist

}

function pick_one_item_random(list)
{
	if array_length(list)==0{
		return "empty"
	}
	return list[irandom_range(0,array_length(list)-1)]
}


function workstation_get_summoned_items()
{
	var itemslist=[]
	with(obj_work_station)
	{
		for(var i=0;i<array_length(spawn_item_pool);i++)
		{
			if spawn_item_pool[i]!="goon_show" && spawn_item_pool[i]!="reward"{
				array_push(itemslist,spawn_item_pool[i])
				if onemore_chance{
					array_push(itemslist,spawn_item_pool[i])
				}
			}
		}
	}
	return itemslist

}

function workstation_get_all_possible_items()
{
	var itemslist=[]
	
		/*for(var i=0;i<array_length(spawn_item_pool);i++)
		{
			if spawn_item_pool[i]!="goon_show" && spawn_item_pool[i]!="reward"{
				array_push(itemslist,spawn_item_pool[i])
				if onemore_chance{
					array_push(itemslist,spawn_item_pool[i])
				}
			}
		}
		/*for(var i=0;i<array_length(crafting_reward_pool);i++)
		{
			if crafting_reward_pool[i]!="goon_show" && crafting_reward_pool[i]!="reward"&& crafting_reward_pool[i]!="goon_blue"{
				array_push(itemslist,crafting_reward_pool[i])
				array_push(itemslist,crafting_reward_pool[i])
				if onemore_chance{
					array_push(itemslist,crafting_reward_pool[i])
				}
			}
		}*/
		
	
	var summoned=workstation_get_summoned_items()
	var crafted= workstation_get_craftable_items()
	itemslist=array_concat(crafted,summoned,itemslist)
	return itemslist
}



function get_all_possible_items()
{
	var itemslist=workstation_get_all_possible_items()
	with (obj_item)
	{
		array_push(itemslist,item_id)
	}


	return itemslist

}


function create_work_station(_x,_y,station_id)
{
	var station =instance_create_depth(_x,_y,depth,obj_work_station)
	station.station_id=station_id
	with(station)
	{
		assign()
	}
	return station

}

function workstation_turn_to_item(_id)
{
	if _id.object_index==obj_work_station
	{
	
		var item_name=(workstation_to_item(_id.station_id))
		instance_destroy(_id)
		return item_name
	}
	return "empty"
}

function workstation_to_item(station_id)
{
	return "station-"+station_id
}

function work_station_texture_get(station_id)
{
	return work_station_data_get(station_id).texture
}

function work_station_item_texture_get(station_id)
{
	return work_station_data_get(station_id).carry_texture
}


function work_station_use_sound_get(station_id)
{
	var data= work_station_data_get(station_id)
	if data.crafting
	{
		return data.craft_sound
	}
	return data.summon_sound
}
function workstation_tags_get(station_id)
{
	return work_station_data_get(station_id).tags

}
function workstation_tags_contain(station_id,tag)
{
	return array_contains(workstation_tags_get(station_id),tag)

}


function work_station_data_get(station_id){
	var work_station_data={tags:[],npc_room_data:{},name:"empty",primordeal_goo:false,third:false,destroy_after:-1,
		station_id:"empty",craft_sound:"empty",summon_sound:"empty",texture:spr_empty,carry_texture:spr_empty,
		grow_stage_timer:[0,0],grown_up_event:[],growth_index:0,grow_stage_sprites:[],
		spawning:false,crafting:false,growing:false,npc_place:false,craft_input_pool_tags:[],craft_reward_pool:[],spawn_item_pool:[],
		spawn_timer_sec:[0,0]}
	work_station_data.station_id=station_id
	work_station_data.name=string_upper(string_copy(station_id,1,1))+ string_replace_all(string_copy(station_id,2,string_length(station_id)-1),"_"," ")
	if station_id=="turnip_plant"
	{
		work_station_data.tags=["can_walk_through","unpickupable"]
		work_station_data.texture=spr_workstation_turnip
		work_station_data.growing=true
		work_station_data.grow_stage_timer=[3,4]
		work_station_data.grown_up_event=[["summon_item_from_pool",["turnip"]],["destroy"]]
		work_station_data.growth_index=0
		work_station_data.grow_stage_sprites=[spr_workstation_turnip,spr_workstation_turnip_second,spr_workstation_turnip_third]
		
	}
	if station_id=="corn_plant"
	{
		work_station_data.tags=["can_walk_through","unpickupable"]
		work_station_data.texture=spr_workstation_corn_plant
		work_station_data.growing=true
		work_station_data.grow_stage_timer=[7,8]
		work_station_data.grown_up_event=[["summon_item_from_pool",["corn_cob"]],["reset_growth_index",1],["destroy_if_reset_reached",3]]
		work_station_data.growth_index=0
		work_station_data.grow_stage_sprites=[spr_workstation_corn_plant,spr_workstation_corn_plant_second,spr_workstation_corn_plant_third]
		
	}
	if station_id=="cat_tail_plant"
	{
		work_station_data.tags=["can_walk_through","unpickupable"]
		work_station_data.texture=spr_workstation_cattail_plant_stem
		work_station_data.growing=true
		work_station_data.grow_stage_timer=[20,30]
		work_station_data.grown_up_event=[["summon_item_from_pool",["cat_tail"]],["create_clone_nearby",1,
		function(xx,yy)
		{
			return gridmode_check_ground_hitboxes_near_water(xx,yy,spr_ui_grid_cattail) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,spr_ui_grid_cattail)
		},"cat_tail_plant"],["create_clone_nearby",1,
		function(xx,yy)
		{
			return gridmode_check_ground_hitboxes_near_water(xx,yy,spr_ui_grid_cattail) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,spr_ui_grid_cattail)
		},"cat_tail_plant"],
		["create_clone_nearby",1,
		function(xx,yy)
		{
			return gridmode_check_ground_hitboxes_near_water(xx,yy,spr_ui_grid_cattail) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,spr_ui_grid_cattail)
		},"cat_tail_plant"],
		["create_clone_nearby",1,
		function(xx,yy)
		{
			return gridmode_check_ground_hitboxes_near_water(xx,yy,spr_ui_grid_cattail) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,spr_ui_grid_cattail)
		},"cat_tail_plant"],["destroy"]]
		work_station_data.growth_index=0
		work_station_data.grow_stage_sprites=[spr_workstation_cattail_plant_stem,spr_workstation_cattail_plant,spr_workstation_cattail_plant_2]
		
	}
	if station_id=="pineapple_plant"
	{
		work_station_data.tags=["can_walk_through","unpickupable"]
		work_station_data.texture=spr_workstation_pineapple
		work_station_data.growing=true
		work_station_data.grow_stage_timer=[10,16]
		work_station_data.grown_up_event=[["summon_item_from_pool",["pineapple"]],["destroy"]]
		work_station_data.growth_index=0
		work_station_data.grow_stage_sprites=[spr_workstation_pineapple,spr_workstation_pineapple_1,spr_workstation_pineapple_2,spr_workstation_pineapple_3,spr_workstation_pineapple_3,spr_workstation_pineapple_4]
		
	}
	if station_id=="purple_mushroom_plant"
	{
		work_station_data.tags=["can_walk_through","unpickupable"]
		work_station_data.texture=spr_workstation_purple_mushroom
		work_station_data.growing=true
		work_station_data.grow_stage_timer=[10,12]
		work_station_data.grown_up_event=[["summon_item_from_pool",["purple_mushroom"]],["create_clone_nearby",0.6,
		function(xx,yy)
		{
			return gridmode_check_ground_hitboxes_dirty_fromtop(xx,yy,spr_ui_grid_purple_mushroom) && gridmode_check_workstation_hitboxes_fromtop(xx,yy,spr_ui_grid_purple_mushroom)
		},"purple_mushroom_plant"],["destroy"]]
		work_station_data.growth_index=0
		work_station_data.grow_stage_sprites=[spr_workstation_purple_mushroom,spr_workstation_purple_mushroom_2,spr_workstation_purple_mushroom_full]
		
	}
	if station_id=="elderberry_plant"
	{
		work_station_data.tags=["can_walk_through","unpickupable"]
		work_station_data.texture=spr_workstation_elderberry_plant
		work_station_data.growing=true
		work_station_data.grow_stage_timer=[3,5]
		work_station_data.grown_up_event=[["summon_item_from_pool",["elderberry"]],["reset_growth_index",3],["destroy_if_reset_reached",12]]
		work_station_data.growth_index=0
		work_station_data.grow_stage_sprites=[spr_workstation_elderberry_plant,spr_workstation_elderberry_plant_2,spr_workstation_elderberry_plant_3,spr_workstation_elderberry_plant_3,spr_workstation_elderberry_plant_4]
		
	}
	if station_id=="trashcan"
	{
		work_station_data.carry_texture=spr_workstation_trashbin_carry
		work_station_data.texture=spr_workstation_trashbin
		work_station_data.spawning=true
		work_station_data.summon_sound="groundsoft"
		work_station_data.spawn_item_pool=["banana","sock"]
		work_station_data.spawn_timer_sec=[10,20]
	}
	if station_id=="crop_seller"
	{
		work_station_data.texture=spr_crop_seller
		work_station_data.npc_place=true
		work_station_data.npc_room_data=npc_room_data_get_base()
		var npc=work_station_data.npc_room_data
		npc.show_money=true
		npc.show_npc=true
		npc.npc_to_draw.sprite=spr_crop_seller_npc_gui
		npc.npc_to_draw.sound="gloob"
		npc.npc_to_draw.size=7
		npc.returning_items_show={show:true,startx:250,starty:610,spacingx:50,spacingy:2,size:5,shadow:true,clampx:50*5*12,clampy:-1}
		npc.room_tiles=
		[
			npc_create_room_tile_data(spr_cropseller_plank,6,30,300),
			npc_create_room_tile_data(spr_cropseller_plank,6,30,500),
			npc_create_room_tile_data(spr_cropseller_ground,6,684,768),
			npc_create_room_tile_data(spr_cropseller_box,6,30,700)
		]
		npc.offerings=
		[
			npc_create_offering_data("hoe",5,120,460,3),
			npc_create_offering_data("corn_seeds",5,100,260,3),
			npc_create_offering_data("turnip_seeds",5,230,264,4),
			npc_create_offering_data("elderberry_seeds",5,360,262,2),
			npc_create_offering_data("pineapple_seeds",5,480,264,1),
			npc_create_offering_data("cat_tail_seeds",5,230,464,1),
			npc_create_offering_data("purple_mushroom_spores",5,610,264,1)
		]
		
	}
	else if station_id=="mystery_man"
	{
		work_station_data.texture=spr_mystery_man
		work_station_data.npc_place=true
		work_station_data.npc_room_data=npc_room_data_get_base()
		var npc=work_station_data.npc_room_data
		npc.show_money=true
		npc.show_npc=true
		npc.npc_to_draw.sprite=spr_mystery_man_npc
		npc.npc_to_draw.sound="bloog"
		npc.npc_to_draw.size=7
		npc.nearby_items_show={show:true,startx:870,starty:250,spacingx:51,spacingy:4,size:5,shadow:true,clampx:(50)*9,clampy:-1}
		npc.returning_items_show={show:true,startx:250,starty:610,spacingx:50,spacingy:2,size:5,shadow:true,clampx:50*5*12,clampy:-1}
		
		npc.room_tiles=
		[
			npc_create_room_tile_data(spr_cropseller_ground,6,684,748),
			npc_create_room_tile_data(spr_mystery_man_brougth_items,6,750,170),
			npc_create_room_tile_data(spr_mystery_man_board,6,10,140),
			npc_create_room_tile_data(spr_cropseller_box,6,30,700)
		]
		npc.offerings=
		[
		]
		npc.active_quests_show={show:true,topleft_coord:[120,200],size:3}
		npc.active_quests=[
		npc_create_quest("Dinner","Satiate my drooling desire for a Turnip.",["turnip"],function(){return true},["ball_and_chain","fly_hive"]),
		npc_create_quest("Pest Control","These nuisances are driving me insane, bring them to me.",["wloob_confused","wloob_confused","wloob_confused"],function(){return true},["candy","fly_hive"])
		]
		
	}
	else if station_id=="brewery"
	{
		work_station_data.carry_texture=spr_brewery_move
		work_station_data.texture=spr_brewery
		work_station_data.npc_place=true
		work_station_data.npc_room_data=npc_room_data_get_base()
		var npc=work_station_data.npc_room_data
		npc.show_money=false
		npc.show_npc=true
		npc.npc_to_draw.sprite=spr_brewery_npc
		npc.npc_to_draw.sound="murr"
		npc.npc_to_draw.size=7
		//npc.nearby_items_show={show:true,startx:870,starty:250,spacingx:51,spacingy:4,size:5,shadow:true,clampx:(50)*9,clampy:-1}
		
		npc.room_tiles_below=
		[
			npc_create_room_tile_data(spr_cropseller_ground,6,684,748),
			npc_create_room_tile_data(spr_brewery_plank,7,0,200)
		]
		npc.offerings=
		[
		]
		npc.active_quests_show={show:true,topleft_coord:[120,200],size:3}
		npc.active_quests=[
		]
		npc.summoned_objects=[npc_create_object(obj_brewery_nearby_items,0,0),npc_create_object(obj_brewery_cauldron,300,400),npc_create_object(obj_brewery_recipe_base,400,0)]
		
		
		
	}
	else if station_id=="woodcutter"
	{
		work_station_data.carry_texture=spr_workstation_woodcuttercarry
		work_station_data.texture=spr_workstation_woodcutter
		work_station_data.crafting=true
		work_station_data.craft_sound="woodwork"
		work_station_data.craft_input_pool_tags=["logs"]
		work_station_data.craft_reward_pool=["plank"]
	}
	else if station_id=="frozen_goon"
	{
		work_station_data.texture=spr_goon_frozen
		work_station_data.crafting=true
		work_station_data.craft_sound="unfreeze"
		work_station_data.craft_input_pool_tags=["cigarette"]
		work_station_data.craft_reward_pool=["goon_show"]
		work_station_data.destroy_after=1
	}
	else if station_id=="nightstand"
	{
		work_station_data.carry_texture=spr_workstation_nightstand_carry
		work_station_data.texture=spr_workstation_nightstand
		work_station_data.crafting=true
		work_station_data.craft_sound="woodwork"
		work_station_data.craft_input_pool_tags=["logs","rock","sock"]
		work_station_data.craft_reward_pool=["lamp"]
		work_station_data.third=true
	}
	else if station_id=="cauldron"
	{
		work_station_data.carry_texture=spr_workstation_cauldron
		work_station_data.texture=spr_workstation_cauldron
		work_station_data.crafting=true
		work_station_data.craft_sound="murr"
		work_station_data.craft_input_pool_tags=["frog","frog","candy","sock"]
		work_station_data.craft_reward_pool=["goon_blue"]
		work_station_data.third=true
	}
	else if station_id=="cigs"
	{
		work_station_data.carry_texture=spr_workstation_cigs_carry
		work_station_data.texture=spr_workstation_cigs
		work_station_data.crafting=true
		work_station_data.craft_sound="woodwork"
		work_station_data.craft_input_pool_tags=["plank","banana"]
		work_station_data.craft_reward_pool=["cigarette"]
		work_station_data.third=true
	}
	else if station_id=="gumball_machine"
	{
		work_station_data.carry_texture=spr_workstation_gumball_machinecarry
		work_station_data.texture=spr_workstation_gumball_machine
		work_station_data.crafting=true
		work_station_data.craft_sound="eat"
		work_station_data.craft_input_pool_tags=["rock","rock","rock","banana"]
		work_station_data.craft_reward_pool=["candy"]
		work_station_data.third=true
	}
	else if station_id=="gooball_machine"
	{
		
		work_station_data.carry_texture=spr_workstation_gumball_machinecarry
		work_station_data.texture=spr_workstation_gooball_machine_1
		work_station_data.crafting=true
		work_station_data.craft_sound="murr"
		work_station_data.craft_input_pool_tags=["frog","candy","cigarette","banana"]
		work_station_data.craft_reward_pool=["goo"]
		work_station_data.third=true
	}
		else if station_id=="tree"
	{
		work_station_data.carry_texture=spr_workstation_tree_carry
		work_station_data.texture=spr_workstation_tree
		work_station_data.spawning=true
		work_station_data.summon_sound="groundmedium"
		work_station_data.spawn_item_pool=["logs"]
		work_station_data.spawn_timer_sec=[20,40]
		
	}
	else if station_id=="frogs"
	{
		work_station_data.carry_texture=spr_workstation_frogs_carry
		work_station_data.texture=spr_workstation_frogs
		work_station_data.spawning=true
		work_station_data.summon_sound="groundsoft"
		work_station_data.spawn_item_pool=["frog","frog","banana"]
		work_station_data.spawn_timer_sec=[15,22]		
		work_station_data.crafting=true
		work_station_data.craft_sound="woodwork"
		work_station_data.craft_input_pool_tags=["frog","lamp"]
		work_station_data.craft_reward_pool=["froglamp"]
		work_station_data.third=true
	}
		else if station_id=="sign"
	{
		work_station_data.carry_texture=spr_workstation_constructioncarry
		work_station_data.texture=spr_workstation_construction
		work_station_data.spawning=true
		work_station_data.summon_sound="groundmedium"
		work_station_data.spawn_item_pool=["rock"]
		work_station_data.spawn_timer_sec=[20,30]
	}
	else if station_id=="primordeal_goo"
	{
		work_station_data.tags=["unpickupable"]
		work_station_data.texture=spr_primordial_goo
		work_station_data.primordeal_goo=true
		//work_station_data.crafting=true
		work_station_data.craft_sound="eat"
		//work_station_data.craft_input_pool_tags=global.objective_list
		//work_station_data.craft_reward_pool=["reward"]
	}
	else if station_id=="goonificator"
	{
		work_station_data.carry_texture=spr_goonificator_carry
		work_station_data.texture=spr_goonificator
		work_station_data.crafting=true
		work_station_data.craft_sound="murr"
		work_station_data.craft_input_pool_tags=["goo"]
		work_station_data.craft_reward_pool=["goon_show"]
	}
	if work_station_data.carry_texture==spr_empty
	{work_station_data.carry_texture=work_station_data.texture}
	return work_station_data
}

function list_contains_sublist(bigArray, subArray)
{
    if (array_length(subArray) == 0) return true;

    var countMap = ds_map_create();
    var nBig = array_length(bigArray);
    for (var i = 0; i < nBig; ++i)
    {
        var v = bigArray[i];
        if (ds_map_exists(countMap, v))
            countMap[? v] += 1;
        else
            ds_map_add(countMap, v, 1);
    }

    var nSub = array_length(subArray);
    for (var j = 0; j < nSub; ++j)
    {
        var w = subArray[j];
        if (!ds_map_exists(countMap, w) || countMap[? w] <= 0)
        {
            ds_map_destroy(countMap);
            return false;
        }
        countMap[? w] -= 1;
    }

    ds_map_destroy(countMap);
    return true;
}


function workstation_scatter(station_id)
{

	create_work_station(irandom_range(32,room_width-32),irandom_range(140,global.room_height-32),station_id)


}