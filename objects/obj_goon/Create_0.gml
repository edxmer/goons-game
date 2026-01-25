gooning=false
goon_speed=irandom_range(160,300) /3
goto_x=x
goto_y=y

all_distance=0


distance_went=0
step_distance=goon_speed*0.3

inventory="empty"
inventory_sprite=spr_empty


possible_names = [
  "Goon", "The Goon", "Gooner", "Goonie", "Goonster", 
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
	
}


workstation_nearby_accepst_my_item =function()
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
			if array_contains(crafting_input_ids,item)
			{
				return true
			}
		
		}
	
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