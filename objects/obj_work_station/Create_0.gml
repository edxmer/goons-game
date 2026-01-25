crafting=false
spawning=false
sprite_index=spr_empty
station_id="empty"

crafting_recipes=[{input:["item","empty"],create_sec:0,output:["item","empty"]}]
spawning_timer=[0,0]
spawning_time=0
spawn_item_pool=["empty"]

assigned=false

assign=function()
{
	assigned=true
	var station_data=work_station_data_get(station_id)
	crafting=station_data.crafting
	spawning=station_data.spawning
	spawning_timer=station_data.spawning_timer
	spawn_item_pool=station_data.spawn_item_pool
	
	
	
	
	
	set_spawning_timer()
}

set_spawning_timer=function()
{
spawning_time=irandom_range(spawning_timer[0],spawning_timer[1])
}


summon_item_from_pool=function(item_pool)
{
	
}