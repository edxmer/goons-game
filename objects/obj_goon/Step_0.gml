
reached_destination_this_frame=false
pixels_taken_this_frame=0

var dt=delta_time/1000000

if global.reward_mode
{
	jump_timer+=delta_time/90000*random_range(0.8,1.2)
	z=max(0,cos(jump_timer)*jump_height)
	
}
else
{
	z=0
	 if jump_timer>360{
		jump_timer=irandom_range(180,359)
	 }
}

if dumb && item_type!="goon_show_dumb"
{
	item_type="goon_show_dumb"
}
else if blue &&item_type!="goon_show_blue"
{
	item_type="goon_show_blue"
}
else if !blue && !dumb && item_type!="goon_show"
{
	item_type="goon_show"
}


if dumb && goon_speed>=(160/3)
{
	sprite_index=spr_goon_dumb
	goon_speed=irandom_range(120,140)/3
}
if blue && goon_speed<=(300/3)
{
	sprite_index=spr_goon_blue
	goon_speed*=3
}

popped_goto_act="empty"
//var y_coord=(y+bbox_bottom)/2
var speed_real=goon_speed*min(dt,0.4)*slowness_modifier
if !(point_distance(x,y,goto_x,goto_y)<speed_real){
	rotation_real=point_direction(x,y,goto_x,goto_y)
	goto_x=clamp(goto_x,global.camera_top_left_x,global.camera_bot_right_x)
	goto_y=clamp(goto_y,global.camera_top_left_y,global.camera_bot_right_y)
	var look=point_direction(x,y,goto_x,goto_y)
	var dir_x=lengthdir_x(speed_real,look)
	var lookx=sign(dir_x)
	var dir_y=lengthdir_y(speed_real,look)
	var looky=sign(dir_y)
	if abs(dir_y)>abs(dir_x/1.5)
	{
		backwards=sign(looky)==-1
	}
	else
	{
		backwards=false
	}
	equipment_sprite_draw=equipment_sprite_walk
	if backwards
	{
		
		sprite_index=spr_goon_walk_backwards
	}
	else{
		sprite_index=spr_goon_walk
	}
	if dumb{
		if backwards
		{
		
			sprite_index=spr_goon_walk_dumb_backwards
		}
		else{
			sprite_index=spr_goon_walk_dumb
		}
	
	}
	else if blue{
		if backwards
		{
		
			sprite_index=spr_goon_walk_blue_backwards
		}
		else{
			sprite_index=spr_goon_walk_blue
		}
	
	}

	distance_went+=speed_real
	pixels_taken_this_frame=speed_real
	x+=clamp(lengthdir_x(speed_real,look),-point_distance(x,y,goto_x,y),point_distance(x,y,goto_x,y))
	if lookx!=0 && abs(dir_x)>=abs((dir_y>>1)){
		image_xscale=lookx
	}
	y+=clamp(lengthdir_y(speed_real,look),-point_distance(x,y,x,goto_y),point_distance(x,y,x,goto_y))
	

	if point_distance(x,y,goto_x,goto_y)<speed_real{
		x=goto_x
		y=goto_y
		if !next_goto()
		{
			reached_destination_this_frame=true
		
			
			
			if distance_went>=step_distance*0.5{
				if is_on_snow(x,y){
					sound_play_category_at("footstep_snow",x,y)
				}
				else{
					
					sound_play_category_at("footstep_stone",x,y)
				}
				
			}
			distance_went=0
			
			
			interact_function()
			x=goto_x
			y=goto_y
		}

	}
}
else
{
	next_goto()
}

if distance_went>=step_distance
{
	distance_went=0
	if is_on_snow(x,y)
	{
		sound_play_category_at("footstep_snow",x,y)
	}
	else
	{
		sound_play_category_at("footstep_stone",x,y)
	}
	particle_footstep(x,bbox_bottom)
}

if position_meeting(mouse_x,mouse_y,id) && global.goon_edit_id!=id
{
	selected=true
	var min_y=bbox_bottom
	with (obj_goon)
	{
		if selected && min_y<bbox_bottom
		{
			min_y=bbox_bottom
		}
	}
	if min_y>bbox_bottom
	{
		
		selected=false
	}
}
else if selected==true
{
	selected=false
}

if selected && mouse_check_button_pressed(mb_right)
{
	edit_goon(id)
}

effect_tick(id)

got_new_directions=false
use_item=false
gridmode_use_item=false

if inventory!="empty"
{
	inventory_subimg += (delta_time / 1000000) * sprite_get_speed(inventory_sprite);
    inventory_subimg = inventory_subimg mod sprite_get_number(inventory_sprite);
}

if dumb && goto_list_changed
{
	goto_x=2*x-goto_x
	goto_y=2*y-goto_y
	for (var i=0;i<array_length(goto_list);i++)
	{
		var change_goto=goto_list[i]
		if is_array(change_goto) && array_length(change_goto)>=2
		{
			change_goto[0]=2*x-change_goto[0]
			change_goto[1]=2*y-change_goto[1]
		}
	}

}
goto_list_changed=false


x=clamp(x,global.camera_top_left_x,global.camera_bot_right_x)
y=clamp(y,global.camera_top_left_y,global.camera_bot_right_y)


if pickup_item_penalty>0
{
	pickup_item_penalty-=dt
	pickup_item_penalty=max(0,pickup_item_penalty)

}

if hp<=0
{
	goon_die()
}
else
{
	if invincibility>0
	{
		invincibility=max(invincibility-dt,0)
	}
}