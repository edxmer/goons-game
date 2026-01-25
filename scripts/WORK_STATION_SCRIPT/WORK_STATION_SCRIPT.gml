function create_work_station(_x,_y,station_id)
{
	var station =instance_create_layer(_x,_y,layer,obj_work_station)
	station.station_id=station_id

}


function work_station_data_get(station_id){
	var work_station_data={station_id:"empty",texture:spr_empty,spawning:false,crafting:false,craft_input_pool_tags:[],craft_reward_pool:[],spawn_item_pool:[],spawn_timer_sec:[0,0]}
	work_station_data.station_id=station_id
	
	if station_id=="trashcan"
	{
		work_station_data.texture=spr_workstation_trashbin
		work_station_data.spawning=true
		work_station_data.spawn_item_pool=["banana","sock"]
		work_station_data.spawn_timer_sec=[10,20]
	}
	else if station_id=="woodcutter"
	{
		work_station_data.texture=spr_workstation_woodcutter
		work_station_data.crafting=true
		work_station_data.craft_input_pool_tags=["logs"]
		work_station_data.craft_reward_pool=["plank"]
	}
	
	return work_station_data
}

function list_contains_sublist(bigList, subList)
{
var countMap = ds_map_create();

    // Count elements in big list
    for (var i = 0; i < ds_list_size(bigList); i++)
    {
        var v = ds_list_find_value(bigList, i);
        
        if (ds_map_exists(countMap, v))
            countMap[? v] += 1;
        else
            countMap[? v] = 1;
    }

    // Subtract required elements
    for (var j = 0; j < ds_list_size(subList); j++)
    {
        var v = ds_list_find_value(subList, j);

        if (!ds_map_exists(countMap, v) || countMap[? v] <= 0)
        {
            ds_map_destroy(countMap);
            return false;
        }

        countMap[? v] -= 1;
    }

    ds_map_destroy(countMap);
    return true;
}



