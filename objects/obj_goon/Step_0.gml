
reached_destination_this_frame=false
pixels_taken_this_frame=0

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
	var speed_real=goon_speed*min(delta_time/1000000,0.4)*slowness_modifier
if x!=goto_x || y!=goto_y{
	equipment_sprite_draw=equipment_sprite_walk
	sprite_index=spr_goon_walk
	if dumb{
			sprite_index=spr_goon_walk_dumb
	
	}
	else if blue{
			sprite_index=spr_goon_walk_blue
	}
	var look=point_direction(x,y,goto_x,goto_y)

	distance_went+=speed_real
	pixels_taken_this_frame=speed_real
	x+=clamp(lengthdir_x(speed_real,look),-point_distance(x,y,goto_x,y),point_distance(x,y,goto_x,y))
	var lookx=sign(lengthdir_x(speed_real,look))
	if lookx!=0 && abs(lengthdir_x(speed_real,look))>=abs((lengthdir_y(speed_real,look)>>1)){
		image_xscale=lookx
	}
	y+=clamp(lengthdir_y(speed_real,look),-point_distance(x,y,x,goto_y),point_distance(x,y,x,goto_y))
	

	if point_distance(x,y,goto_x,goto_y)<speed_real{
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
			x=goto_x
			y=goto_y
			interact_function()
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


if pickup_item_penalty>0
{
	pickup_item_penalty-=delta_time/1000000
	pickup_item_penalty=max(0,pickup_item_penalty)

}