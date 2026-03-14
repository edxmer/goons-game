wloob_passive_timer=min(max(0,wloob_passive_timer-delta_time/1000000),global.enemy_passive_wloob_timer)
if wloob_passive_timer<=0
{
	wloob_passive_timer=global.enemy_passive_wloob_timer+irandom_range(-2,5)
	create_enemy(0,irandom_range(10,750),obj_enemy_wloob)

}