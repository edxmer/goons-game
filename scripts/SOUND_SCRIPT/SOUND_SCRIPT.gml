function get_sound_all()
{
	var sound_lib=
	{
		footstep:{sound_footstep_snow_1,sound_footstep_snow_2}

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
