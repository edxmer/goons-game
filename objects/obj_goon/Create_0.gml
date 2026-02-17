
if !variable_global_exists("goon_count")
{
global.goon_count=1
}
else{
global.goon_count++
}

goto_list=[]

gridmode_use_item=false

pickup_item_penalty=0

selected=false

gooning=false
speaking = false
goon_speed=irandom_range(160,300) /3
goto_x=x
goto_y=y

equipment="empty"
equipment_sprite_draw=spr_empty
equipment_sprite_idle=spr_empty
equipment_sprite_walk=spr_empty

blue=false
dumb=false
item_type="goon_show"
walked_pixels=0

all_distance=0

use_item=false

got_new_directions=false

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

goon_pickup_item=function(item,replace=false)
{
	if (inventory=="empty" ) || replace{
		inventory=item
		if inventory!="empty"{
			inventory_sprite=assign_item(inventory).texture
			sound_play_category_at("pickup",x,y)
			effect_update(id)
			return true
		}
	}
	return false
}

interact_function=function()
{
	if inventory=="empty" && pickup_item_penalty==0{
		goon_pickup_item(pickup_item(x,y))
		/*inventory=pickup_item(x,y)
		if inventory!="empty"{
			inventory_sprite=assign_item(inventory).texture
			sound_play_category_at("pickup",x,y)
		}*/
	}
	else {
		if workstation_nearby_accepst_my_item()
		{
			put_down_item()
		}
	
	}
	//effect_update(id)
	
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

inventory_set_empty=function()
{
inventory="empty"
inventory_sprite=spr_empty
effect_update(id)
}

goon_summon_item=function(item_id)
{
	sound_play_category_at("groundsoft",x,bbox_bottom)
	create_item(irandom_range(x-5,x+5),irandom_range(y-5,bbox_bottom+3),item_id)
}

goon_place_item_down_grid=function(item_id)
{
	sound_play_category_at("groundsoft",x,bbox_bottom)
	create_item(clamp_to_grid_start( x),clamp_to_grid_start(bbox_bottom),item_id)


}
put_down_item=function()
{
	if inventory!="empty"{
		pickup_item_penalty=0.5
		if item_tags_contains(inventory,"put_down_on_grid")
		{
			goon_place_item_down_grid(inventory)
		}
		else
		{
			goon_summon_item(inventory)
		}
		/*
		sound_play_category_at("groundsoft",x,bbox_bottom)
		create_item(irandom_range(x-5,x+5),irandom_range(y-5,bbox_bottom+3),inventory)
		*/
		inventory_set_empty()
	}
	effect_update(id)
}

stop_goon=function()
{
	goto_x=x
	goto_y=y
	goto_list=[]
}

only_this_goon_gooning=function()
{
	return gooning && gooning_goons_count()==1
}


next_goto=function()
{
	if array_length(goto_list)==0
	{
		equipment_sprite_draw=equipment_sprite_idle
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
		array_delete(goto_list,0,1)
		if next_go=="interact"
		{
			
			interact_function()
			
		}
		else if next_go=="gridmode_useitem"
		{
			gridmode_use_item=true
			use_item=true
		}
		else if next_go="nothing"
		{
		
		}
		else
		{
			
			goto_x=next_go[0]
			goto_y=next_go[1]
		}
		return true
	}
}
equip_item_base=function(item)
{
	if item_tags_contains(item,"equippable")
	{
		var was_equip=equipment
		sound_play_category_at("equip",x,y)
		var both_sprites=item_id_get_equip_sprites(item)
		equipment=item
		equipment_sprite_idle=both_sprites[0]
		equipment_sprite_walk=both_sprites[1]
		equipment_sprite_draw=equipment_sprite_idle
		effect_update(id)
	}
}

equip_item_from_hand=function()
{
	if item_tags_contains(inventory,"equippable")
	{
		var was_equip=equipment
		sound_play_category_at("equip",x,y)
		var both_sprites=item_id_get_equip_sprites(inventory)
		equipment=inventory
		equipment_sprite_idle=both_sprites[0]
		equipment_sprite_walk=both_sprites[1]
		equipment_sprite_draw=equipment_sprite_idle
		inventory_set_empty()
		goon_pickup_item(was_equip)
		effect_update(id)
	}
}

equipment_set_empty=function()
{
	equipment="empty"
	equipment_sprite_idle=spr_empty
	equipment_sprite_walk=spr_empty
	equipment_sprite_draw=equipment_sprite_idle
	effect_update(id)

}

unequip_item=function()
{
	if equipment!="empty"
	{
		if !goon_pickup_item(equipment)
		{
			goon_summon_item(equipment)
		}
	}
	equipment_set_empty()
	
}