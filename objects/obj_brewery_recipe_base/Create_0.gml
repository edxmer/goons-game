recipe_down=false
size=7
image_xscale=size
image_yscale=size
board_y=0
onmouse=false
board_y_smooth=0
board_y_max=0

board_held=false
last_mouse_y=0

godown=function()
{
	board_y-=17*size
	with(obj_brewery_recipe)
	{
		y_real-=17*size
	}
}

board_up=function()
{
	sound_play_category_at("boarddown",x,y)
	recipe_down=false
}


calc_max_y=function()
{
	var recipes=global.npc_brewery.known_recipes
	return size*34*ceil(array_length(recipes)/3)+34*size

}

board_down=function()
{
	board_y=0
	recipe_down=true
		board_y_max=17*size*4
	global.npc_brewery.new_recipe=false
	sound_play_category_at("boardup",x,y)
	var recipes=global.npc_brewery.known_recipes
	startx=bbox_left+19*size
	starty=size*(34+34)-calc_max_y()+min(34*size,ceil(array_length(recipes)/3)*17*size)
	for (var i=0;i<array_length(recipes);i++)
	{
		
		var rec=instance_create_layer(startx,starty,"Instances_in_room",obj_brewery_recipe)
		rec.recipe=recipes[i]
		rec.base_y=starty
		startx+=27*size
		if i%3==2
		{
			startx=bbox_left+19*size
			starty+=34*size
		}
	
	}
	
}