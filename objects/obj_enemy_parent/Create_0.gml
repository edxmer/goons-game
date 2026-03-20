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

item_to_be_turned_into="empty"

located_object=noone
locate_object=false

current_ai="idle"
_curr_speed=0
timer1=0

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