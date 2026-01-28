function get_sound_all()
{
	var sound_lib=
	{
		footstep:[sound_footstep_snow_1,sound_footstep_snow_2,sound_footstep_snow_3],
		pickup:[sound_pickup_item_1,sound_pickup_item_2],
		murr:[sound_goon_murr_2,sound_goon_murr_1,sound_goon_murr_3],
		woodwork:[sound_wood_work],
		stonework:[sound_stone_work_1,sound_stone_work_2],
		groundsoft:[sound_item_ground_1,sound_item_ground_2],
		swoosh:[sound_whoosh],
		eat:[sound_eat_1,sound_eat_2],
		freeze:[sound_freeze],
		unfreeze:[sound_glass_break]

	}

	return sound_lib
}

function get_sound_list(category)
{
	var sound_lib=get_sound_all()
	if variable_struct_exists(sound_lib,category)
	{
		return variable_struct_get(sound_lib,category)
	}
	return [sound_empty]
}


function pick_sound_sound_list(sound_list)
{
	if array_length(sound_list)==0{
		return sound_empty
	}
	return sound_list[irandom_range(0,array_length(sound_list)-1)]

}

function sound_set_listener_pos()
{
	var cam = view_camera[0];

	var lx = camera_get_view_x(cam) + camera_get_view_width(cam) * 0.5;
	var ly = camera_get_view_y(cam) + camera_get_view_height(cam) * 0.5;

	audio_listener_set_position(0,lx, ly, 0);
}
function sound_play_at(sound,_x,_y)
{
	sound_set_listener_pos()
	audio_play_sound_at(sound,_x,_y,0,10,50,3,false,1)

}

function sound_play_category_at(category,_x,_y)
{
	var slist=get_sound_list(category)
	var sound=pick_sound_sound_list(slist)
	sound_play_at(sound,_x,_y)

}