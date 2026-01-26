function draw_workstation(_x,_y,station_id,scale)
{
	var sprite=work_station_data_get(station_id).texture
	draw_sprite_ext(sprite,0,_x,_y,scale,scale,0,c_white,1)

}

function workstation_get_all_possible_items()
{
	var itemslist=[]
	with(obj_work_station)
	{
		for(var i=0;i<array_length(spawn_item_pool);i++)
		{
			if spawn_item_pool[i]!="goon_show" && spawn_item_pool[i]!="reward"{
				array_push(itemslist,spawn_item_pool[i])
			}
		}
		for(var i=0;i<array_length(crafting_reward_pool);i++)
		{
			if crafting_reward_pool[i]!="goon_show" && crafting_reward_pool[i]!="reward"{
				array_push(itemslist,crafting_reward_pool[i])
			}
		}
	
	}
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

}


function work_station_data_get(station_id){
	var work_station_data={primordeal_goo:false,station_id:"empty",craft_sound:"empty",summon_sound:"empty",texture:spr_empty,spawning:false,crafting:false,craft_input_pool_tags:[],craft_reward_pool:[],spawn_item_pool:[],spawn_timer_sec:[0,0]}
	work_station_data.station_id=station_id
	
	if station_id=="trashcan"
	{
		work_station_data.texture=spr_workstation_trashbin
		work_station_data.spawning=true
		work_station_data.summon_sound="groundsoft"
		work_station_data.spawn_item_pool=["banana","sock"]
		work_station_data.spawn_timer_sec=[10,20]
	}
	else if station_id=="woodcutter"
	{
		work_station_data.texture=spr_workstation_woodcutter
		work_station_data.crafting=true
		work_station_data.craft_sound="woodwork"
		work_station_data.craft_input_pool_tags=["logs"]
		work_station_data.craft_reward_pool=["plank"]
	}
	else if station_id=="nightstand"
	{
		work_station_data.texture=spr_workstation_nightstand
		work_station_data.crafting=true
		work_station_data.craft_sound="woodwork"
		work_station_data.craft_input_pool_tags=["logs","rock","sock"]
		work_station_data.craft_reward_pool=["lamp"]
	}
	else if station_id=="cigs"
	{
		work_station_data.texture=spr_workstation_cigs
		work_station_data.crafting=true
		work_station_data.craft_sound="woodwork"
		work_station_data.craft_input_pool_tags=["plank","banana","banana"]
		work_station_data.craft_reward_pool=["cigarette"]
	}
		else if station_id=="tree"
	{
		work_station_data.texture=spr_workstation_tree
		work_station_data.spawning=true
		work_station_data.summon_sound="groundsoft"
		work_station_data.spawn_item_pool=["logs"]
		work_station_data.spawn_timer_sec=[20,40]
	}
		else if station_id=="sign"
	{
		work_station_data.texture=spr_workstation_construction
		work_station_data.spawning=true
		work_station_data.summon_sound="groundsoft"
		work_station_data.spawn_item_pool=["rock"]
		work_station_data.spawn_timer_sec=[20,30]
	}
	else if station_id=="primordeal_goo"
	{
		work_station_data.texture=spr_primordial_goo
		work_station_data.primordeal_goo=true
		work_station_data.crafting=true
		work_station_data.craft_sound="eat"
		work_station_data.craft_input_pool_tags=global.objective_list
		work_station_data.craft_reward_pool=["reward"]
	}
	else if station_id=="goonificator"
	{
		work_station_data.texture=spr_goonificator
		work_station_data.crafting=true
		work_station_data.craft_sound="murr"
		work_station_data.craft_input_pool_tags=["goo"]
		work_station_data.craft_reward_pool=["goon_show"]
	}
	
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

	create_work_station(irandom_range(32,room_width-32),irandom_range(140,room_height-32),station_id)


}