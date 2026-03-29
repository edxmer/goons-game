// Inherit the parent event
event_inherited();
priority=3

reset_zoom=new_sign("Reset Zoom",function() 
	{
			with(obj_camera)
			{
				zoom_to_back=global.default_camera_size
				real_x=global.cam.coords[0]+(width_base*global.camera_size-width_base*global.default_camera_size)*0.66
				real_y=global.cam.coords[1]+(height_base*global.camera_size-height_base*global.default_camera_size)*0.66
			}
	}
	)

select_all=new_sign("Select All",
		function ()
		{
			with(obj_goon)
			{
				sound_play_category_at("murr",x,y)
				gooning=true
			}
		}
	)
select_nearest=new_sign("Select Nearest",function()
{
	var options=[]
	with(obj_goon)
	{
		if !gooning
		{
			array_push(options,[id,point_distance(x,y,global.cam.coords_middle[0],global.cam.coords_middle[1])])
		}
	}
	if array_length(options)>0
	{
		var least=options[0][1]
		var least_id=options[0][0]
		for (var i=1;i<array_length(options);i++)
		{
			if options[i][1]>least
			{
				least=options[0][1]
				least_id=options[0][0]
			}
		}
		with(least_id)
		{
			sound_play_category_at("murr",x,y)
			gooning=true
		}
	}
}
)

unselect_nearest=new_sign("Unselect Nearest",function()
{
	var options=[]
	with(obj_goon)
	{
		if gooning
		{
			array_push(options,[id,point_distance(x,y,global.cam.coords_middle[0],global.cam.coords_middle[1])])
		}
	}
	if array_length(options)>0
	{
		var least=options[0][1]
		var least_id=options[0][0]
		for (var i=1;i<array_length(options);i++)
		{
			if options[i][1]>least
			{
				least=options[0][1]
				least_id=options[0][0]
			}
		}
		with(least_id)
		{
			gooning=false
		}
	}
}
)
unselect_all=new_sign("Unselect All",
		function ()
		{
			with(obj_goon)
			{
				gooning=false
			}
		}
	)

signs=[
	reset_zoom,select_all
	
	
]
sprite_index=spr_ui_icon_select
real_x=1220
real_y=340