event_inherited();
if current_ai=="run_middle"
{
	sprite=spr_wloob_run
	movement_modificator=1.2
	locate_object=false
	if goto_x<3
	{
		goto_x=(room_width/2)+irandom_range(-(room_width/4),(room_width/4))
		goto_y=clamp(y+irandom_range(15,40)*one_or_minus_one(),10,750)
	}
	else
	{
		if not_moving()
		{
			current_ai="find_food"
		}
	}
}
if current_ai=="find_food"
{
	locate_object=false
	movement_modificator=0.8
	
	if !instance_exists(located_object)
	{
		if pickup_tries<=0
		{
			current_ai="run_away"
		}
		pickup_tries--
		located_object=search_for_nearest_item_with_calories(x,y)
		timer1=random_range(7,12)
		
	}
	else if timer1>0 && not_moving()
	{
		sprite=spr_wloob_idle
		goto_x=x+irandom_range(10,20)*one_or_minus_one()
		goto_y=y+irandom_range(10,20)*one_or_minus_one()
	}
	else if timer1<=0
	{
		current_ai="fetch"
	}
	
}
if current_ai=="fetch"
{
	movement_modificator=1
	if !instance_exists(located_object)
	{
		located_object=noone
		current_ai="find_food"
	}
	else
	{
		locate_object=true
		sprite=spr_wloob_run
		
		if point_distance(x,y,located_object.x,located_object.y)<=movement_speed_per_second*delta_time/500000
		{
			current_ai="pickup"
		}
	}

}

if current_ai=="pickup"
{
	if instance_exists(located_object)
	{
		array_push(inventory,located_object.item_id)
		instance_destroy(located_object)
		sound_play_category_at("pickup",x,y)
		current_ai="run_away"
	}
	else
	{
		current_ai="find_food"
	}


}

if current_ai=="run_away"
{
	if x<=-10
	{
		instance_destroy()
	}
	else
	{
		if goto_x>=-10
		{
			goto_x=-20
			goto_y=y+irandom_range(30,40)*one_or_minus_one()
		}
	}
	
	if array_length(inventory)==0
	{
		sprite=spr_wloob_run
		movement_modificator=1
	
	}
	else
	{
		sprite=spr_wloob_run
		movement_modificator=1
	}



}