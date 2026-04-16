// Inherit the parent event
event_inherited();
rolling=false
name="Homonculus"
item_to_be_turned_into="homonculus"
inventory_size=1
sprite=spr_homonculus
locate_object=false
located_object=noone
death_sprite=spr_goo_yellow
loot=["goo"]

movement_speed_per_second=irandom_range(50,80)

current_ai="find_guy"
size=1
current_guy=noone

picked_up_script=function(){
	sound_play_category_at("murr",x,y)
	drop_inventory()
	instance_destroy()
}

tags=["pickuppable"]