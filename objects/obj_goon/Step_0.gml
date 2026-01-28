if dumb && goon_speed>=(160/3)
{
	sprite_index=spr_goon_dumb
	goon_speed=irandom_range(120,140)/3
}


if goto_x!=x && goto_y!=y{
	sprite_index=spr_goon_walk
	if dumb{
			sprite_index=spr_goon_walk_dumb
	
	}
	else if blue{
			sprite_index=spr_goon_walk_blue
	}
	var look=point_direction(x,y,goto_x,goto_y)
	var speed_real=goon_speed*min(delta_time/1000000,0.4)
	distance_went+=speed_real
	x+=lengthdir_x(speed_real,look)
	var lookx=sign(lengthdir_x(speed_real,look))
	if lookx!=0{
		image_xscale=lookx
	}
	
	y+=lengthdir_y(speed_real,look)

	if point_distance(x,y,goto_x,goto_y)<speed_real{
		sprite_index=spr_goon
		if dumb{
			sprite_index=spr_goon_dumb
		}
		else if blue{
			sprite_index=spr_goon_blue
		}
		if distance_went>=step_distance*0.5{
			sound_play_category_at("footstep",x,y)
		}
		distance_went=0
		goto_x=x
		goto_y=y
		interact_function()
	}
}

if distance_went>=step_distance
{
	distance_went=0
	sound_play_category_at("footstep",x,y)
}

