// Inherit the parent event
event_inherited();
priority=3

name="Select"

option_hover=false
options_on=false
options_text="Options"


changed_option=function()
{
	with (obj_goon)
	{
		if gooning && !other.is_goon_useful(id)
		{
			gooning=false
		}
	}

}

show_options=false

is_goon_useful=function(_id)
{
	return (global.option_blue || !(_id.blue))
	&& (global.option_dumb || !(_id.dumb))
	&& (global.option_normal || (_id.dumb || _id.blue))
	&& (!global.option_empty || _id.inventory=="empty")
	&& (!global.option_no_equip || !(array_contains( _id.active_effect_list,"weird_tag")))
}

useful_goons_count=function()
{
	var cnt=0
	with(obj_goon)
	{
		if other.is_goon_useful(id)
		{
			cnt++
		}
	}
	return cnt
}


global.option_no_equip=true
option_no_equip_sign=new_sign("No Equip",function(){
	global.option_no_equip=!global.option_no_equip;
	if global.option_no_equip
	{
		option_no_equip_sign.icon=spr_ui_icon_icon_option_tick
	}
	else
	{
		option_no_equip_sign.icon=spr_ui_icon_icon_option_untick
	
	}
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_blue=true
option_blue_sign=new_sign("Blue",function(){
	global.option_blue=!global.option_blue;
	if global.option_blue
	{
		option_blue_sign.icon=spr_ui_icon_icon_option_tick
	}
	else
	{
		option_blue_sign.icon=spr_ui_icon_icon_option_untick
	
	}
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_dumb=true
option_dumb_sign=new_sign("Dumb",function(){
	global.option_dumb=!global.option_dumb;
	if global.option_dumb
	{
		option_dumb_sign.icon=spr_ui_icon_icon_option_tick
	}
	else
	{
		option_dumb_sign.icon=spr_ui_icon_icon_option_untick
	
	}
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_normal=true
option_normal_sign=new_sign("Normal",function(){
	global.option_normal=!global.option_normal;
	if global.option_normal
	{
		option_normal_sign.icon=spr_ui_icon_icon_option_tick
	}
	else
	{
		option_normal_sign.icon=spr_ui_icon_icon_option_untick
	
	}
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_empty=false
option_empty_sign=new_sign("No Items",function(){
	global.option_empty=!global.option_empty;
	if global.option_empty
	{
		option_empty_sign.icon=spr_ui_icon_icon_option_tick
	}
	else
	{
		option_empty_sign.icon=spr_ui_icon_icon_option_untick
	
	}
	changed_option()
	},false,spr_ui_icon_icon_option_untick,{has:false,func:empty_func()},spr_ui_icon_button_option)

slider_level=0
slider_yy=real_y
slider_selected=false
slider_clicked_on=false
calc_slider_y=function()
{
	
	slider_yy=show_y+20*size+27*size-(min(gooning_goons_count(),useful_goons_count())/max(1,useful_goons_count()))*27*size
	
}

hov_gui_check=function()
{
	return on_mouse || sign_selected!=-1 || slider_selected || option_hover||on_arrows
}

reset_zoom=new_sign("Reset Zoom",function() 
	{
			with(obj_camera)
			{
				zoom_to_back=global.default_camera_size
				real_x=global.cam.coords[0]+(width_base*global.camera_size-width_base*global.default_camera_size)*0.66
				real_y=global.cam.coords[1]+(height_base*global.camera_size-height_base*global.default_camera_size)*0.66
			}
	},false,spr_ui_icon_icon_reset_cam
	)

select_all=new_sign("Select All",
		function ()
		{
			with(obj_goon)
			{
				if other.is_goon_useful(id)
				{
					sound_play_category_at("murr",x,y)
					gooning=true
				}
			}
		},true
	)
select_nearest=new_sign("+1",function()
{
	var options=[]
	with(obj_goon)
	{
		if !gooning &&other.is_goon_useful(id)
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
			if options[i][1]<least
			{
				least=options[i][1]
				least_id=options[i][0]
			}
		}
		with(least_id)
		{
			global.last_selected_goon=id
			sound_play_category_at("murr",x,y)
			gooning=true
		}
	}
},true
)

unselect_nearest=new_sign("-1",function()
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
				least=options[i][1]
				least_id=options[i][0]
			}
		}
		with(least_id)
		{
			gooning=false
		}
	}
},true
)
unselect_all=new_sign("Unselect All",
		function ()
		{
			with(obj_goon)
			{
				gooning=false
			}
		},true
	)

signs=[
	reset_zoom,select_all
	
	
]
sprite_index=spr_ui_icon_select
real_x=1320-size*10
real_y=40+size*10+size*24*2