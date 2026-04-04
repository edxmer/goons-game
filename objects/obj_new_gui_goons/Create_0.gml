// Inherit the parent event
event_inherited();
priority=2

name="Goons"

sprite_index=spr_ui_icon_goon



real_x=1320-size*10
real_y=40+size*10+size*24
edit_last_1=new_sign("Edit Last",function(asd)
{
	if global.last_selected_goon!=noone && instance_exists(global.last_selected_goon)
	{
		if global.goon_edit_id!=global.last_selected_goon
		{
			edit_goon(global.last_selected_goon)
		}
		else
		{
			exit_goon_edit_mode()
		}
	}},false,spr_ui_icon_icon_edit_last,{has:true,func:function(_id){return _id.id==global.last_selected_goon}})
edit_last_no=new_sign("Escape Edit",function(asd)
{
	if global.last_selected_goon!=noone && instance_exists(global.last_selected_goon)
	{
		if global.goon_edit_id!=global.last_selected_goon
		{
			edit_goon(global.last_selected_goon)
		}
		else
		{
			exit_goon_edit_mode()
		}
	}},false,spr_ui_icon_icon_edit_last,{has:false,func:empty_func()})

edit_last=edit_last_1

signs=[edit_last]

unselect=new_sign("Unselect",function(goon){goon.gooning=false},false,spr_ui_icon_icon_unselect,{has:true,func:function(_id){return _id.gooning==true}})



button_clicked=function()
{
	if sign_selected!=-1
	{
		if signs[sign_selected].name==edit_last.name
		{
			signs[sign_selected].func(obj_goon)
		}
		else
		{
			if gooning_goons_count()>0
			{
				var idgooning=[]
				with(obj_goon)
				{
					if gooning
					{
						array_push(idgooning,id)
					}
				}
				for (var i=0;i<array_length(idgooning);i++)
				{
					signs[sign_selected].func(idgooning[i])
				}
			}
			else if instance_exists(global.last_selected_goon)
			{
				signs[sign_selected].func(global.last_selected_goon)
			}
		}
	}

}