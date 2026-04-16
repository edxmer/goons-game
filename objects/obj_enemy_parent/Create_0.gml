hp=1
z=0

sprite=spr_empty

name="Enemy"

selected=false

inventory=[]
inventory_size=0
xscale_base=1
xscale_turn=1
yscale_base=1
size=1
turn_left_right=true

goto_points=[]

goto_x=x 
goto_y=y 

movement_speed_per_second=80
movement_modificator=1

idle=true
idle_time=0

tags=[]
//understood_tags="pickuppable"

active_effects=[]

has_shadow=true
shadow_size=1

loot=[]

invincible_sec=0.5
invincibility=0

has_hitbox=true
can_be_hit=true
round_about_size=8

item_to_be_turned_into="empty"

located_object=noone
locate_object=false

current_ai="idle"
_curr_speed=0
timer1=0

death_sprite=spr_blood

attack_script=function(){}
hurt_script=function(amount){}
picked_up_script=function(){}
not_moving=function()
{
	return abs(goto_x-x)<_curr_speed && abs(goto_y-y)<_curr_speed
}

drop_inventory=function()
{
	for (var i=0;i<array_length(inventory);i++)
	{
		var item=inventory[i]
		sound_play_category_at(item_get_ground_sound(item),x,y)
		
		create_item(x,y,item)
	}
}

drop_loot=function()
{
	for (var i=0;i<array_length(loot);i++)
	{
		var item=loot[i]
		sound_play_category_at(item_get_ground_sound(item),x,y)
		
		create_item(x,y,item)
	}
}

enemy_die_particle=function()
{
	particle_summon_from_texture_multiple(x,y,death_sprite,irandom_range(10,16))
	particle_spirit(x,y)

}


enemy_die=function()
{
	enemy_die_base(id)
	instance_destroy()
}

is_not_invincible=function()
{
	return invincibility<=0 && has_hitbox && can_be_hit

}