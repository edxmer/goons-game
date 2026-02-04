
if !variable_global_exists("goon_count")
{
global.goon_count=1
}
else{
global.goon_count++
}

goto_list=[]


selected=false

gooning=false
speaking = false
goon_speed=irandom_range(160,300) /3
goto_x=x
goto_y=y

blue=false
dumb=false
item_type="goon_show"
walked_pixels=0

all_distance=0



distance_went=0
step_distance=goon_speed*0.3

inventory="empty"
inventory_sprite=spr_empty
has_effects=false
effect_init(id)
//effect_data_stay={freezing:{freezing_pixel_taken:0}}


pixels_taken_this_frame=0
reached_destination_this_frame=false

slowness_modifier=1


possible_names = [
  "Goon","Spoon", "The Goon", "Gooner", "Goonie", "Goonster", 
  "Goonling", "Goonlet", "Goon Jr.", "Goon Sr.", "Lil Goon", 
  "Big Goon", "Goon Squad", "Goon Platoon", "Goon Lagoon", "Dragoon", 
  "Rangoon", "Raccoon Goon", "Tycoon Goon", "Buffoon Goon", "Balloon Goon", 
  "Saloon Goon", "Moon Goon", "Noon Goon", "Soon Goon", "Spoon Goon", 
  "Cartoon Goon", "Cocoon Goon", "Monsoon Goon", "Typhoon Goon", "Pontoon Goon", 
  "Bassoon Goon", "Maroon Goon", "Goonzilla", "King Goon", "Queen Goon", 
  "Prince Goon", "Sir Goon", "Lord Goon", "Baron Goon", "Count Goon", 
  "Dr. Goon", "Prof. Goon", "Goon Solo", "Goon Skywalker", "Darth Goon", 
  "Iron Goon", "Spider-Goon", "Batgoon", "Supergoon", "Captain Goon", 
  "Goondalf", "Aragoon", "Legoonlas", "Goon Wick", "James Goond", 
  "Sherlock Goons", "Harry Gooner", "Goonbot", "Robogoon", "Mechagoon", 
  "Cybergoon", "iGoon", "Goon 2.0", "Goon XP", "Goon Vista", 
  "Goon.exe", "Goon.bat", "404 Goon", "Glitch Goon", "Pixel Goon", 
  "Voxel Goon", "Sprite Goon", "Texture Goon", "Collider Goon", "Script Goon", 
  "Object Goon", "Instance Goon", "Null Goon", "NaN Goon", "Segfault Goon", 
  "Goonchad", "Sigmagoon", "Goonpilled", "Based Goon", "Cringe Goon", 
  "Sussy Goon", "Goonus", "Goongus", "Goonjak", "Goonmaxxer", 
  "Rizzgoon", "Skibidi Goon", "Gyatt Goon", "Fanum Goon", "Ohio Goon", 
  "Mewing Goon", "Yapping Goon", "Goonwich", "Macaroon Goon", "Goonana","Goon 2","Jorjor Well","Goon #402"
]
name = possible_names[irandom(array_length(possible_names)-1)]

interact_function=function()
{
	if inventory=="empty"{
		inventory=pickup_item(x,y)
		if inventory!="empty"{
			inventory_sprite=assign_item(inventory).texture
			sound_play_category_at("pickup",x,y)
		}
	}
	else {
		if workstation_nearby_accepst_my_item()
		{
			put_down_item()
		}
	
	}
	effect_update(id)
	
}


workstation_nearby_accepst_my_item =function(get_id_instead=false)
{
	var _x=x
	var _y=y
	var item=inventory
	with(obj_work_station)
	{
		var x_min=bbox_left-20
		var x_max=bbox_right+20
		var y_min=bbox_top-10
		var y_max=bbox_bottom+20
		if point_in_rectangle(_x,_y,x_min,y_min,x_max,y_max)
		{
			if get_id_instead{
				return id
			}
			if array_contains(crafting_input_ids,item)
			{
				return true
			}
		
		}
	
	}
	if get_id_instead{
		return noone
	}
	return false



}


put_down_item=function()
{
	if inventory!="empty"{
		sound_play_category_at("groundsoft",x,bbox_bottom)
		create_item(irandom_range(x-5,x+5),irandom_range(y-5,bbox_bottom+3),inventory)
		inventory="empty"
		inventory_sprite=spr_empty
	}
}

stop_goon=function()
{
	goto_x=x
	goto_y=y
	goto_list=[]
}


next_goto=function()
{
	if array_length(goto_list)==0
	{
		sprite_index=spr_goon
		if dumb{
			sprite_index=spr_goon_dumb
		}
		else if blue{
			sprite_index=spr_goon_blue
		}
		return false
	}
	else
	{
		
		var next_go=goto_list[0]
		if next_go=="interact"
		{
			array_delete(goto_list,0,1)
			interact_function()
			
		}
		else
		{
			array_delete(goto_list,0,1)
			goto_x=next_go[0]
			goto_y=next_go[1]
		}
		return true
	}
}