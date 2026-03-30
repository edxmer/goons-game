// Inherit the parent event

if active
{
	
	if global.goon_edit_mode
	{
		edit_last=edit_last_no
	}
	else
	{
		edit_last=edit_last_1
	}
	
	signs=[edit_last]
	if gooning_goons_count()>0
	{
		array_push(signs,unselect)
	}
	var functions=[]
	with(obj_goon)
	{
		if gooning
		{
			functions=array_concat(functions,goon_get_buttons(id))
		
		}

	}
	functions=array_to_distinct(functions)
	var idno=array_get_index(functions,"unselect")
	if idno!=-1
	{
		array_delete(functions,idno,1)
	}
	
	var idnoP=array_get_index(functions,"pickup")
	var idnoS=array_get_index(functions,"switch")
	if idnoP!=-1 && idnoS!=-1
	{
		array_delete(functions,idnoP,1)
	}
	array_sort(functions, function(a, b) {
	    if (a < b) return -1;
	    if (a > b) return 1;
	    return 0;
	});
	for (var i=0;i<array_length(functions);i++)
	{
		var data=get_edit_button_data(functions[i])
		array_push(signs,new_sign(data.realname,data.act,false,data.icon_gui,data.arrow))
	}
}


event_inherited();

