if !assigned
{
	assign()
	useful=useful_function()
}

if size<1
{
	size+=0.08
	size=min(1,size)
}
if !grew_up && size>=0.95{
	grew_up=true
	if item_id="goon_show" && size>=0.95
	{
		instance_create_depth(x,y,depth,obj_goon)
		instance_destroy()
	}

	else if item_id="goon_show_dumb" && size>=0.95
	{
		var dumb=instance_create_depth(x,y,depth,obj_goon)
		dumb.dumb=true
		instance_destroy()
	}

	else if item_id="goon_show_blue" && size>=0.95
	{
		var blue=instance_create_depth(x,y,depth,obj_goon)
		blue.blue=true
		instance_destroy()
	}
	else if item_id="goon_blue" && size>=0.95
	{
		var changed=false
		with(obj_goon){
			if !changed && !blue && !dumb{
				blue=true
				sound_play_category_at("murr",x,y)
				goon_speed*=3
				sprite_index=spr_goon_blue
				changed=true
			}
		
		}
		instance_destroy()
	}

	else if item_id="reward" && size>=0.95
	{
		instance_create_depth(x,y,depth,obj_reward_base)
		instance_destroy()
	}


	else if string_copy(item_id,1,8)=="station-"
	{
		var _station_id=string_copy(item_id,9,string_length(item_id)-8)
		create_work_station(x,y-10,_station_id)
		instance_destroy()
	}
}