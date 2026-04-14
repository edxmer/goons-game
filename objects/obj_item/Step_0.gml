if !assigned
{
	assign()
	useful=useful_function()
	check_in_water()
}

if turn_into_object
{
	turn_after-=delta_time/1000000
	if turn_after<=0
	{
		instance_create_depth(x,y,0,turn_into)
		instance_destroy()
	}

}


if size<1
{
	size+=0.08
	size=min(1,size)
}
if !grew_up && size>=0.95{
	grew_up=true
	if item_id="goon_show" && size>=0.95
	{
		instance_create_depth(x,y,depth,obj_goon)
		instance_destroy()
	}

	else if item_id="goon_show_dumb" && size>=0.95
	{
		var dumb=instance_create_depth(x,y,depth,obj_goon)
		dumb.dumb=true
		instance_destroy()
	}

	else if item_id="goon_show_blue" && size>=0.95
	{
		var blue=instance_create_depth(x,y,depth,obj_goon)
		blue.blue=true
		instance_destroy()
	}
	else if item_id="goon_blue" && size>=0.95
	{
		var changed=false
		with(obj_goon){
			if !changed && !id.blue && !id.dumb{
				id.blue=true
				sound_play_category_at("murr",x,y)
				goon_speed*=3
				sprite_index=spr_goon_blue
				changed=true
			}
		
		}
		instance_destroy()
	}

	else if item_id="reward" && size>=0.95
	{
		if !instance_exists(obj_reward_base) && !global.special_mode
		{
			instance_create_depth(x,y,depth,obj_reward_base)
			instance_destroy()
		}
		else
		{
			grew_up=false
		}
	}



}

if !global.is_hovering_gui && position_meeting(mouse_x,mouse_y,id) && !global.special_mode && !global.is_hovering_gui
{
	selected=true
	with(obj_work_station)
	{
		if selected{
			other.selected=false
		}
	}
	with(obj_goon)
	{
		if selected{
			other.selected=false
		}
	}
	var min_y=bbox_bottom
	with(obj_item)
	{
		if selected && bbox_bottom<min_y{
			min_y=bbox_bottom
		}
	}
	if min_y<bbox_bottom{
		selected=false
	}
}
else
{
	selected=false
}
if irandom_range(0,10)==10
{
	sleeping_movement=false
}

if !sleeping_movement
{
	new_item_move_from_collisions(id)

}

if abs(x-show_x)>0.5 || abs(y-show_y)>0.5
{
	show_x=show_x*0.4+x*0.6
	show_y=show_y*0.4+y*0.6
}
else
{
	show_x=x
	show_y=y
}