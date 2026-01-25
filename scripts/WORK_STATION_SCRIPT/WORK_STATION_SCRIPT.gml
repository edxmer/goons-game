function work_station_data_get(station_id){
	var work_station_data={station_id:"empty",texture:spr_empty,spawning:false,crafting:false,spawn_item_pool:[],spawn_timer_sec:[0,0]}
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
}