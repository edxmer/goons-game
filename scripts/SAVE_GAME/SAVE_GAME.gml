function get_saves()
{	
	var saves=[]
	if file_exists("savefiles/existing_savefiles.txt")
	{
		var fileid=file_text_open_read("savefiles/existing_savefiles.txt")
		while(!file_text_eof(fileid))
		{
			var save=file_text_readln(fileid)
			var savemod=string_split(save,"-")
			if savemod[0]=="savefile"
			{
				var savename=savemod[1]
				array_push(saves,savename)
			}
		}
	}
	else
	{
		var fileid=file_text_open_write("savefiles/existing_savefiles.txt")
		file_text_close(fileid)
	}
	return saves
}

function add_saves_existing(savename)
{	
	var saves=get_saves()
	if !array_contains(saves,savename)
	{
		array_push(saves,savename)
		var fileid=file_text_open_write("savefiles/existing_savefiles.txt")
		if fileid==-1
		{
			return false
		}
		for (var i=0;i<array_length(saves);i++)
		{
			file_text_write_string(fileid,"savefile-"+saves[i]+"-")
		}
		file_text_close(fileid)
	}
	return true
}


function value_to_savestring(value,_layer=0)
{
	var return_text=""
	if is_array(value)
	{
		return_text+="LIST#"
		for (var i=0;i<array_length(value);i++)
		{
			if i!=0
			{
				return_text+=","
			}
			return_text+=value_to_savestring(value[i],_layer+1)
		}
		
	}
	
	else if is_numeric(value)
	{
		return_text+="NUM#"+string(value)
	
	}
	else
	{
		return_text+="STRING#"+string(value)
	
	}
	
	return return_text
}


function handle_value_from_savestring(savestring)
{
	var value=0
	var alls=string_split(savestring,"#",false,1)
	var type=alls[0]
	var strval=alls[1]
	if type=="LIST"
	{
		value=[]
		var cont=string_split(strval,",")
		for (var i=0;i<array_length(cont);i++)
		{
			array_push(value,handle_value_from_savestring(cont[i]))
		}
		
	}
	
	else if type=="NUM"
	{
		value=real(strval)
	
	}
	else
	{
		value=strval
	
	}
	return value

}

function create_savestring_globals(varname)
{
	if !variable_global_exists(varname)
	{
		return ""
	}
	
	var text="global-"
	text+=varname+"-"

	
	text+=value_to_savestring(variable_global_get(varname))
	text+="-\n"
	return text

}
function handle_savestring_globals(save_modules)
{
	if save_modules[0]!="global"
	{
		return false
	}
	var name=save_modules[1]
	var value=handle_value_from_savestring(save_modules[2])
	
	variable_global_set(name,value)

	return true

}

function create_savestring_ground()
{
	var text="ground-"
	var endy=(room_height>>4)
	var endx=room_width>>4

	for (var yy=0;yy<endy;yy++)
	{
		if yy!=0
		{
			text+="["
		}
		for (var xx=0;xx<endx;xx++)
		{
			if xx!=0
			{
				text+=","
			}
			text+=string(get_tile_index(xx,yy))
		}

	}
	text+="-\n"
	return text

}




function handle_savestring_ground(save_modules)
{

	if save_modules[0]!="ground"
	{
		return false
	}
	
	var allg=save_modules[1]
	var ys=string_split(allg,"[")
	for (var yy=0;yy<array_length(ys);yy++)
	{
		var xs=string_split(ys[yy],",")
		for (var xx=0;xx<array_length(xs);xx++)
		{
			set_tile_index(xx,yy,real(xs[xx]))
		}
	}
	return true
}






function create_save(fname){
	var fileid=file_text_open_write("savefiles/"+fname+".txt")
	if fileid==-1
	{
		return false
	}
	
	add_saves_existing(fname)
	
	file_text_write_string(fileid,"$globals\n")
	file_text_write_string(fileid,create_savestring_globals("objective_list"))
	file_text_write_string(fileid,create_savestring_globals("reward_level"))
	file_text_write_string(fileid,create_savestring_globals("island_unlocked"))
	file_text_write_string(fileid,create_savestring_globals("room_height"))
	file_text_write_string(fileid,create_savestring_globals("camera_room_height"))
	file_text_write_string(fileid,"$ground\n")
	file_text_write_string(fileid,create_savestring_ground())
	
	file_text_write_string(fileid,"$goons\n")
	with(obj_goon)
	{
		file_text_write_string(fileid,create_savestring_goon(id))
	}
	file_text_write_string(fileid,"$workstations\n")
	with(obj_work_station)
	{
		file_text_write_string(fileid,create_savestring_workstation(id))
	}
	file_text_write_string(fileid,"$items\n")
	with(obj_item)
	{
		file_text_write_string(fileid,create_savestring_item(id))
	}
	file_text_close(fileid)
	return true
}

function handle_savestring_goon(save_modules)
{

	if save_modules[0]!="goon"
	{
		return false
	}
	var coords=string_split(save_modules[2],"_")
	var _x=real(coords[0])
	var _y=real(coords[1])
	var goon_id=create_goon(_x,_y)
	
	goon_id.name=save_modules[1]
	
	
	var type=save_modules[3]
	
	if type=="d"{
		goon_id.dumb=true
		
	}
	else if type=="b"{
		goon_id.blue=true
	}
	goon_id.goon_speed=real(save_modules[6])
	with(goon_id)
	{
		goon_pickup_item(save_modules[4])
		equip_item_base(save_modules[5])
	}
	
	return true
}

function create_savestring_goon(goon_id)
{
	if !instance_exists(goon_id) || goon_id.object_index!=obj_goon
	{
		return ""
	}
	var text="goon-"
	
	text+=goon_id.name+"-"
	text+=string(goon_id.x)+"_"+string(goon_id.y)+"-"
	var type="n"
	if goon_id.dumb{
		type="d"
	}
	else if goon_id.blue{
		type="b"
	}
	text+=type+"-"
	text+=goon_id.inventory+"-"
	text+=goon_id.equipment+"-"
	text+=string(goon_id.goon_speed)
	text+="-\n"
	return text
}

function handle_savestring_workstation(save_modules)
{

	if save_modules[0]!="workstation"
	{
		return false
	}
	
	
	var station_id=save_modules[1]
	var coords=string_split(save_modules[2],"_")
	var _x=real(coords[0])
	var _y=real(coords[1])
	
	create_work_station(_x,_y,station_id)

	return true
}
function create_savestring_workstation(workstation_id)
{
	if !instance_exists(workstation_id) || workstation_id.object_index!=obj_work_station
	{
		return ""
	}
	var text="workstation-"
	text+=workstation_id.station_id+"-"
	text+=string(workstation_id.x)+"_"+string(workstation_id.y)
	text+="-\n"
	return text
}

function handle_savestring_item(save_modules)
{

	if save_modules[0]!="item"
	{
		return false
	}
	
	
	var item_id=save_modules[1]
	var coords=string_split(save_modules[2],"_")
	var _x=real(coords[0])
	var _y=real(coords[1])
	
	create_item(_x,_y,item_id)

	return true
}
function create_savestring_item(item_id)
{
	if !instance_exists(item_id) || item_id.object_index!=obj_item
	{
		return ""
	}
	var text="item-"
	text+=item_id.item_id+"-"
	text+=string(item_id.x)+"_"+string(item_id.y)
	text+="-\n"
	return text
}

function does_save_exist(filename)
{


	return file_exists("savefiles/"+filename+".txt")
	
}

function handle_saveline(save_modules)
{
	if save_modules[0]=="goon"
	{
		handle_savestring_goon(save_modules)
	}
	else if save_modules[0]=="workstation"
	{
		handle_savestring_workstation(save_modules)
	}
	else if save_modules[0]=="item"
	{
		handle_savestring_item(save_modules)
	}
	else if save_modules[0]=="ground"
	{
		handle_savestring_ground(save_modules)
	}
	else if save_modules[0]=="global"
	{
		handle_savestring_globals(save_modules)
	}
}




function open_save(fname)
{
	var fileid=file_text_open_read("savefiles/"+fname+".txt")
	if fileid==-1
	{
		return false
	}
	while (!file_text_eof(fileid))
	{
		var line=file_text_readln(fileid)
		if !string_starts_with(line,"$")
		{
			var modules=string_split(line,"-")
			handle_saveline(modules)
		}
	}
	return true
}