real_x=x
real_y=y

size=4

name="Base"

priority=0

button_sprite_index=0

sign_size=12
on_mouse=false
active=false


remove_ind=function()
{
	var _hoverng_arr_ind = array_get_index(global.gui_hovering, id)
	array_delete(global.gui_hovering, _hoverng_arr_ind, 1)
}

add_ind=function()
{
	array_push(global.gui_hovering, id)
}
assigned_y=0

sign_sizes=0

signs=[]

text_mult=0.12

sign_selected=-1

clicksound=function()
{
	sound_play_category_at("click",global.cam.coords_middle[0],global.cam.coords_middle[1])
}

empty_func=function()
{
	return (function(_id){return false})
}
new_sign=function(name,func,small=false,icon=spr_empty,whoarrow={has:false,func:empty_func()})
{
	return {name:name,func:func,small:small,icon:icon,whoarrow:whoarrow}

}


hov_gui_check=function()
{
	return on_mouse || sign_selected!=-1
}
close_up=function()
{
	if active
	{
		with(obj_new_gui_parent)
		{
			
			if priority>other.priority
			{
				real_y=assigned_y
			}
		}
	}
	active=false
}

sign_get_y_coord=function(sign_index)
{
	var yy=real_y+20*size
	yy+=sign_size*size*sign_index
	return yy
}


open_up=function()
{
	if !active
	{
		move_below(sign_sizes)

	}
	active=true

}

move_below=function(amount)
{
	with(obj_new_gui_parent)
		{
			
			if priority>other.priority
			{
				real_y+=amount
			}
		}


}

calculate_sign_size=function()
{
	sign_sizes=array_length(signs)*size*sign_size

}

update_opened=function()
{
	var last=sign_sizes
	calculate_sign_size()
	var diff = sign_sizes - last
	if abs(diff )>1
	{
		move_below(diff)
	}

}

button_clicked=function()
{
	if sign_selected!=-1
	{
		signs[sign_selected].func()
	}

}