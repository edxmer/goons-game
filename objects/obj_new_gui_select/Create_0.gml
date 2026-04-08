// Inherit the parent event
event_inherited();
priority=3

name="Select"

option_hover=false
options_on=false
options_text="Options"


mark_only_id=-1
mark_only_yy=0
mark_selected=false

show_options=false

is_goon_useful=function(_id)
{
	return (global.option_blue || !(_id.blue))
	&& (global.option_dumb || !(_id.dumb))
	&& (global.option_normal || (_id.dumb || _id.blue))
	&& (global.option_empty || !(_id.inventory=="empty"))
	&& (global.option_consumable && item_tags_contains( _id.inventory,"consumable") 
	|| global.option_equippable && item_tags_contains( _id.inventory,"equippable") 
	|| global.option_has_calories && (item_get_calories( _id.inventory) >0)
	|| global.option_empty && (_id.inventory=="empty")
	|| global.option_no_calories && (item_get_calories( _id.inventory) ==0)
	|| (!(global.option_no_calories || global.option_has_calories || global.option_equippable || global.option_consumable) && _id.inventory=="empty")
	)
	&& ((global.option_repeating && (array_contains(_id.active_effect_list,"robot")))
	|| (global.option_destruct && (array_contains(_id.active_effect_list,"pick_up_building")))
	|| (global.option_building && (array_contains(_id.active_effect_list,"grid_mode")))
	|| (global.option_tilt_ground && (array_contains(_id.active_effect_list,"tilt_ground")))
	|| (global.option_no_special && !((array_contains(_id.active_effect_list,"tilt_ground")||array_contains(_id.active_effect_list,"grid_mode")||array_contains(_id.active_effect_list,"robot")||array_contains(_id.active_effect_list,"pick_up_building"))))
	)
}

reload_gooning_goons_count=function()
{
	gooning_goons_cnt=gooning_goons_count()
	useful_goons_count()
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
	useful_goons_cnt=cnt
	return cnt
}

update_sign=function(opt_sign,tick_or_untick)
{
	if tick_or_untick
	{
		opt_sign.icon=spr_ui_icon_icon_option_tick
	}
	else
	{
		opt_sign.icon=spr_ui_icon_icon_option_untick
	
	}
}

update_options=function()
{
	update_sign(option_blue_sign,global.option_blue)
	update_sign(option_normal_sign,global.option_normal)
	update_sign(option_dumb_sign,global.option_dumb)
	update_sign(option_building_sign,global.option_building)
	update_sign(option_destruct_sign,global.option_destruct)
	update_sign(option_empty_sign,global.option_empty)
	update_sign(option_consumable_sign,global.option_consumable)
	update_sign(option_equippable_sign,global.option_equippable)
	update_sign(option_no_special_sign,global.option_no_special)
	update_sign(option_has_calories_sign,global.option_has_calories)
	update_sign(option_no_calories_sign,global.option_no_calories)
	update_sign(option_repeating_sign,global.option_repeating)
	update_sign(option_tilt_ground_sign,global.option_tilt_ground)

}

undo_all_other=function(mark_id)
{
	for (var i=0;i<array_length(signs);i++)
	{
		if (signs[i].icon==spr_ui_icon_icon_option_tick) && (i!=mark_id)
		{
			signs[i].func()
		}
		if signs[mark_id].icon!=spr_ui_icon_icon_option_tick
		{
			signs[mark_id].func()
		}
	}
}


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





global.option_blue=true
option_blue_sign=new_sign("Blue",function(){
	global.option_blue=!global.option_blue;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_dumb=true
option_dumb_sign=new_sign("Dumb",function(){
	global.option_dumb=!global.option_dumb;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_normal=true
option_normal_sign=new_sign("Basic",function(){
	global.option_normal=!global.option_normal;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_empty=true
option_empty_sign=new_sign("No Items",function(){
	global.option_empty=!global.option_empty;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)


global.option_consumable=true
option_consumable_sign=new_sign("Consumable",function(){
	global.option_consumable=!global.option_consumable;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_equippable=true
option_equippable_sign=new_sign("Equippable",function(){
	global.option_equippable=!global.option_equippable;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_has_calories=true
option_has_calories_sign=new_sign("Calories",function(){
	global.option_has_calories=!global.option_has_calories;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_no_calories=true
option_no_calories_sign=new_sign("No Calories",function(){
	global.option_no_calories=!global.option_no_calories;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_building=true
option_building_sign=new_sign("Building",function(){
	global.option_building=!global.option_building;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_repeating=true
option_repeating_sign=new_sign("Repeating",function(){
	global.option_repeating=!global.option_repeating;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

global.option_destruct=true
option_destruct_sign=new_sign("Destruct",function(){
	global.option_destruct=!global.option_destruct;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)


global.option_tilt_ground=true
option_tilt_ground_sign=new_sign("Tilt Ground",function(){
	global.option_tilt_ground=!global.option_tilt_ground;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)


global.option_no_special=true
option_no_special_sign=new_sign("No Special",function(){
	global.option_no_special=!global.option_no_special;
	update_options()
	changed_option()
	},false,spr_ui_icon_icon_option_tick,{has:false,func:empty_func()},spr_ui_icon_button_option)

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
	return on_mouse || sign_selected!=-1 || slider_selected || option_hover||on_arrows || option_change_hover || mark_selected
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
			reload_gooning_goons_count()
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
	reload_gooning_goons_count()
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
	reload_gooning_goons_count()
},true
)
unselect_all=new_sign("Unselect All",
		function ()
		{
			with(obj_goon)
			{
				gooning=false
			}
		reload_gooning_goons_count()
		},true
	)

signs=[
	reset_zoom,select_all
	
	
]
sprite_index=spr_ui_icon_select
real_x=1320-size*10
real_y=40+size*10+size*24*2


option_change_hover=false
options_changes_index=0
options_changes=[{uid:"goons",name:"Goons",sprite:spr_ui_icon_button_select_option_goons,signs:[option_normal_sign,option_blue_sign,option_dumb_sign]},
{uid:"equipment",name:"Abilities",sprite:spr_ui_icon_button_select_option_equip,signs:[option_no_special_sign,option_repeating_sign,option_destruct_sign,option_building_sign,option_tilt_ground_sign]},
{uid:"items",name:"Items",sprite:spr_ui_icon_button_select_option_inventory,signs:[option_empty_sign,option_equippable_sign,option_consumable_sign,option_has_calories_sign,option_no_calories_sign]}
]
options_changes_current=options_changes[0]


reload_gooning_goons_count()