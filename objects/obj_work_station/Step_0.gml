if !assigned
{
	assign()
}

if primordeal_goo{
	if eating_time==0
	{
		last_eaten_item_id="empty"
		sprite_index=spr_primordial_goo
		var items_nearby=get_nearby_items_with_calories()
		var maxid=noone
		var max_kcal=0
		for (var i=0;i<array_length(items_nearby);i++)
		{
			if items_nearby[i][1]>max_kcal
			{
				max_kcal=items_nearby[i][1]
				maxid=items_nearby[i][0]
			}
		}
		if maxid!=noone
		{
			var eating_item_id=maxid.item_id
			last_eaten_item_id=eating_item_id
			sprite_index=spr_primordial_goo_eating
			sound_play_category_at("eat",x,y)
			calorie_item_eat(eating_item_id)
			item_destroy_nearby(maxid)
			
		}
		eating_time=eating_timer
	}
	else
	{
		eating_time-=delta_time/1000000
		eating_time=max(0,eating_time)
		if last_eaten_item_id!="empty"
		{
			item_id_summon_particles_less(last_eaten_item_id,x,y)
		}
	}
}

if spawning{
	spawning_time-=delta_time/1000000
	if spawning_time<=0
	{
		set_spawning_timer()
		sound_play_category_at(summon_sound,x,y)
		var pool=spawn_item_pool
		var nearby=get_nearby_item_ids()
		var amount=0
		for (var i=0;i<array_length(nearby);i++)
		{
			if array_contains(pool,nearby[i])
			{
				amount++
			}
		}
		if amount+array_length(interact_recieve_items)<10{
			interact_item_push(get_item_from_pool(spawn_item_pool))
			used_amount++
		}
		else{
			spawning_time/=2
		}
	}
}

if crafting
{
	var items_nearby=get_nearby_item_ids()
	var items_around_cnt=array_length(items_nearby)
	if items_nearby_last!=items_around_cnt
	{
		if list_contains_sublist(items_nearby, crafting_input_ids)
		{
			for (var i=0;i<array_length(crafting_input_ids);i++)
			{
				var cur_item=crafting_input_ids[i]
				item_destroy_nearby(cur_item)
			}
			sound_play_category_at(craft_sound,x,y)
			var closest=goons_get_closest_idle(x,y)
			var item=get_item_from_pool(crafting_reward_pool)
			
			if !item_unpickupable(item) &&closest!=noone && point_distance(closest.x,closest.y,x,y)<=40 && closest.inventory=="empty"
			{
				
				closest.inventory=item
				closest.inventory_sprite=assign_item(item).texture
			}
			else{
				
				summon_item_from_pool([item])
			}
			
			
			used_amount++
		}
	
	
	}
	items_nearby_last=items_around_cnt



}


if growing && !grow_stop{
	grow_time-=delta_time/1000000
	if grow_time<0
	{
		set_growing_time()
		growth_index++
	}
	if growth_index<array_length(grow_stage_sprites) && !can_be_interacted{
		change_sprite(grow_stage_sprites[growth_index])
	}
	if growth_index>=array_length(grow_stage_sprites)
	{
		for (var i=0;i<array_length(grown_up_event);i++)
		{
			var event=grown_up_event[i]
			if event[0]=="destroy"
			{
				//instance_destroy()
				interact_destroy=true
				grow_stop=true
			}
			else if event[0]=="summon_item_from_pool"
			{
				interact_item_push(get_item_from_pool(event[1]))
			}
			else if event[0]=="reset_growth_index"
			{
				growth_index_reseted++
				growth_index=event[1]
				set_growing_time()
			}
			else if event[0]=="destroy_if_reset_reached"
			{
				if growth_index_reseted>=event[1]
				{
					//instance_destroy()
					interact_destroy=true
					grow_stop=true
				}
			}
		}
	
	
	}
	
	





}

var gooninstead=false
	with (obj_goon)
	{
		if selected
		{
			gooninstead=true
		}
	}

if !selected && point_in_rectangle(mouse_x,mouse_y,bbox_left-5,bbox_top-20,bbox_right+5,bbox_bottom+5) && !global.special_mode
{

	if !gooninstead
	{
		var miny=y
		with(obj_work_station)
		{
			if selected && y<miny
			{
				miny=y
			}
		}
		if miny<y{
			selected=false
		}
	

		else {
			sound_play_category_at("swoosh",x,y)
			selected=true
		}
	}

}



else if selected && (!point_in_rectangle(mouse_x,mouse_y,bbox_left-5,bbox_top-20,bbox_right+5,bbox_bottom+5) || gooninstead || global.special_mode)
{
	sound_play_category_at("swoosh",x,y)
	selected=false
}
can_be_interacted=array_length(interact_recieve_items)>0 || interact_destroy
if can_be_interacted
{
interact_tick=clamp(++interact_tick,0,10)
}
else
{
interact_tick=0
}

if destroy_after>=0 && destroy_after<=used_amount
{
	instance_destroy()
}