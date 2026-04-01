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
			file_text_write_string(fileid,"savefile-"+saves[i]+"-\n")
		}
		file_text_close(fileid)
	}
	return true
}


function value_to_savestring(value,_layer=0)
{
	var return_text=""
	var special_char="#"
	
	if is_array(value)
	{

		return_text+="LIST"+special_char
		for (var i=0;i<array_length(value);i++)
		{
			if i!=0
			{
				if _layer==0
				{
					return_text+=","
				}
				else
				{
					return_text+=";"+string(_layer)
				}
			}
			return_text+=value_to_savestring(value[i],_layer+1)
		}
		
	}
	
	else if is_numeric(value)
	{
		if asset_get_type(value)==asset_sprite
		{
			return_text+="SPRITE"+special_char+sprite_get_name(value)
		}
		else
		{
			return_text+="NUM"+special_char+string(value)
		}
	
	}
	else if is_bool(value)
	{
		return_text+="BOOL"+special_char
		if value
		{
			return_text+="TRUE"
		}
		else
		{
			return_text+="FALSE"
		}
	}

	else
	{
		return_text+="STRING"+special_char+string(value)
	
	}
	
	return return_text
}
function is_value_variable_dictionary(savestring_one_module)
{
	return string_char_at(savestring_one_module,1)=="{"

}

function create_value_variable_dictionary_to_string(dict_name,value)
{
	var str_name="{"+dict_name+"}"
	var str_value=value_to_savestring(value)
	return str_name+str_value
}

function handle_value_variable_dictionary(savestring_one_module)
{
	var name="empty"
	var value=0
	if is_value_variable_dictionary(savestring_one_module)
	{
		var newstring=string_copy(savestring_one_module,2,string_length(savestring_one_module)-1)
		var modules=string_split(newstring,"}")
		if array_length(modules)>1
		{
			name=modules[0]
			value=handle_value_from_savestring(modules[1])
		}
	
	}
	return [name,value]
}


function handle_value_dict_id(_id,savestring_one_module)
{
	var modules= handle_value_variable_dictionary(savestring_one_module)
	var dictname=modules[0]
	var dictval=modules[1]
	variable_instance_set(_id,dictname,dictval)

}

function handle_value_from_savestring(savestring,_layer=0)
{
	var value=0
	var splitby_big="#"
	

	var alls=string_split(savestring,splitby_big,false,1)
	var type=alls[0]
	var strval=alls[1]
	if type=="LIST"
	{
		value=[]
		var splitby=","
		if _layer>0
		{
			splitby=";"+string(_layer)
			
		}
		if strval!=""{
			var cont=string_split(strval,splitby)
			for (var i=0;i<array_length(cont);i++)
			{
				array_push(value,handle_value_from_savestring(cont[i],_layer+1))
			}
		}
		
	}
	
	else if type=="NUM"
	{
		if strval==""
		{
			value=0
		}
		else
		{
		value=real(strval)
		}
	}
	else if type=="SPRITE"
	{
		value=asset_get_index(strval)
	}
	else if type=="BOOL"
	{
		value=strval=="TRUE"
	
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
	
	file_text_write_string(fileid,create_savestring_globals("npc_brewery_unlocked_recipes"))
	file_text_write_string(fileid,create_savestring_globals("npc_brewery_known_recipes"))
	file_text_write_string(fileid,create_savestring_globals("npc_brewery_new_recipe"))
	file_text_write_string(fileid,create_savestring_globals("current_calories"))
	file_text_write_string(fileid,create_savestring_globals("coins"))
	file_text_write_string(fileid,create_savestring_globals("needed_calories"))
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
	file_text_write_string(fileid,"$enemies\n")
	with(all)
	{
		if object_is_ancestor(id.object_index,obj_enemy_parent)
		{
			file_text_write_string(fileid,create_savestring_enemy(id))
		}
	}
	file_text_close(fileid)
	return true
}
function create_savestring_enemy_special(enemy_id)
{
	var ret_text=""
	ret_text+=create_value_variable_dictionary_to_string("sprite_index",enemy_id.sprite_index)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("goto_x",enemy_id.goto_x)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("goto_y",enemy_id.goto_y)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("inventory",enemy_id.inventory)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("current_ai",enemy_id.current_ai)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("hp",enemy_id.hp)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("sprite",enemy_id.sprite)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("movement_speed_per_second",enemy_id.movement_speed_per_second)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("tags",enemy_id.tags)
	+"-"
	
	return ret_text

}
function create_savestring_enemy(enemy_id)
{
	if !instance_exists(enemy_id) || !object_is_ancestor(enemy_id.object_index,obj_enemy_parent)
	{
		return ""
	}
	var text="enemy-"
	
	text+=object_get_name(object_index)+"-"
	text+=string(enemy_id.x)+"_"+string(enemy_id.y)+"-"

	text+=create_savestring_enemy_special(enemy_id)
	text+="-\n"
	return text
}
function handle_savestring_enemy(save_modules)
{

	if save_modules[0]!="enemy"
	{
		return false
	}
	var coords=string_split(save_modules[2],"_")
	var _x=real(coords[0])
	var _y=real(coords[1])
	var obj_id= asset_get_index(save_modules[1])
	

	var enemy_id=create_enemy(_x,_y,obj_id)
	

	if array_length(save_modules)>=4
	{
		for(var i=3;i<array_length(save_modules);i++)
		{
			var module=save_modules[i]
			if is_value_variable_dictionary(module)
			{
				handle_value_dict_id(enemy_id,module)
			}
		}
	}
	
	
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
	
	if array_length(save_modules)>=9
	{
		goon_id.verboseness=real(save_modules[7])
	}
	
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
	if array_length(save_modules)>=10
	{
		for(var i=3;i<array_length(save_modules);i++)
		{
			var module=save_modules[i]
			if is_value_variable_dictionary(module)
			{
				handle_value_dict_id(goon_id,module)
			}
		}
	}
	effect_update(goon_id)
	return true
}
function create_savestring_goon_special(goon_id)
{
	var ret_text=""
	ret_text+=create_value_variable_dictionary_to_string("sprite_index",goon_id.sprite_index)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("goto_x",goon_id.goto_x)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("goto_y",goon_id.goto_y)
	+"-"
	ret_text+=create_value_variable_dictionary_to_string("goto_list",goon_id.goto_list)
	+"-"
	
	return ret_text

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
	text+=string(goon_id.goon_speed)+"-"
	text+=string(goon_id.verboseness)+"-"
	text+=create_savestring_goon_special(goon_id)
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
	
	
	
	
	var wst_id=create_work_station(_x,_y,station_id)
	wst_id.assign()
	if array_length(save_modules)>3
	{
		for(var i=3;i<array_length(save_modules);i++)
		{
			var module=save_modules[i]
			if is_value_variable_dictionary(module)
			{
				handle_value_dict_id(wst_id,module)
			}
		}
	}
	
	
	return true
}

function create_savestring_workstation_special(workstation_id)
{
	var ret_text=""
	ret_text+=create_value_variable_dictionary_to_string("sprite_index",workstation_id.sprite_index)
	+"-"
	if array_length(workstation_id.interact_recieve_items)>0
	{
		ret_text+=create_value_variable_dictionary_to_string("interact_recieve_items",workstation_id.interact_recieve_items)
		+"-"
		
	}
	if workstation_id.spawning
	{

		ret_text+=create_value_variable_dictionary_to_string("spawning_time",workstation_id.spawning_time)
		+"-"
	}
	
	if workstation_id.growing
	{
		
		ret_text+=create_value_variable_dictionary_to_string("grow_stop",workstation_id.grow_stop)
		+"-"
		ret_text+=create_value_variable_dictionary_to_string("interact_destroy",workstation_id.interact_destroy)
		+"-"
		ret_text+=create_value_variable_dictionary_to_string("growth_index_reseted",workstation_id.growth_index_reseted)
		+"-"
		ret_text+=create_value_variable_dictionary_to_string("grow_time",workstation_id.grow_time)
		+"-"
		ret_text+=create_value_variable_dictionary_to_string("growth_index",workstation_id.growth_index)
		+"-"
	
	
	}
	return ret_text
}

function create_savestring_workstation(workstation_id)
{
	if !instance_exists(workstation_id) || workstation_id.object_index!=obj_work_station
	{
		return ""
	}
	var text="workstation-"
	text+=workstation_id.station_id+"-"
	text+=string(workstation_id.x)+"_"+string(workstation_id.y)+"-"
	text+=create_savestring_workstation_special(workstation_id)
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
	else if save_modules[0]=="enemy"
	{
		handle_savestring_enemy(save_modules)
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