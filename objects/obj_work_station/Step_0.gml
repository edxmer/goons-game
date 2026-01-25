if !assigned
{
	assign()
}

if spawning{
	spawning_time-=delta_time/1000000
	if spawning_time<=0
	{
		set_spawning_timer()
		summon_item_from_pool(spawn_item_pool)
	}
}