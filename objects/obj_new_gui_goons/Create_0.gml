// Inherit the parent event
event_inherited();
priority=2

sprite_index=spr_ui_icon_goon
real_x=1220
real_y=220

edit_last=new_sign("Edit Last",function(asd)
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
	}})
signs=[edit_last]

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
	}

}