recipe_down=!recipe_down



if recipe_down
{
	sound_play_category_at("boardup",x,y)
	var recipes=["corn_syrup","muting_brew"]
	startx=room_width/2-32*size
	starty=size*16
	for (var i=0;i<array_length(recipes);i++)
	{
		
		instance_create_layer(startx,starty,"Instances_in_room",obj_brewery_recipe).recipe=recipes[i]
		startx+=32*size
		if i%3==0 && i!=0
		{
			startx=room_width/2-32*size
			starty+=32*size
		}
	
	}
	
	

}
else
{
	sound_play_category_at("boarddown",x,y)

}