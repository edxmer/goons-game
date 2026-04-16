// Inherit the parent event
event_inherited();

name="Wloob"
item_to_be_turned_into="wloob_confused"
inventory_size=1
sprite=spr_wloob_idle
locate_object=false
located_object=noone
death_sprite=spr_wloob_particle

loot=["wloob_goo"]

movement_speed_per_second=irandom_range(30,60)

current_ai="run_middle"
size=random_range(1,1.25)
pickup_tries=irandom_range(1,3)

picked_up_script=function(){
	sound_play_category_at("whimper",x,y)
	drop_inventory()
	instance_destroy()
}

tags=["pickuppable"]

enemy_die=function()
{
	enemy_die_base(id)
	sound_play_category_at("whimper",x,y)

}