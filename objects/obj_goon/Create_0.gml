gooning=false
goon_speed=irandom_range(160,300) /3
goto_x=x
goto_y=y

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
  "Mewing Goon", "Yapping Goon", "Goonwich", "Macaroon Goon", "Goonana"
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
	
}
