draw_self()
draw_sprite_ext(spr_brewery_cauldron_potion,potion_step,x,y,scale,scale,0,potion_color,1)

if splash
{
	var frame_t=current_time-dropped_time
	var d_step=floor(frame_t/100)
	if d_step>7
	{
		splash=false
	}
	else{
		draw_sprite_ext(spr_brewery_cauldron_drop,d_step,x+dropped_x,y,scale,scale,0,potion_color,1)
	}
}

