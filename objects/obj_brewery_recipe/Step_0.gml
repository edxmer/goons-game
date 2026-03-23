if bsize<7
{
	bsize++
}
if on_mouse
{
size_mult=1.1
}
else
{
	size_mult=1
}

size=bsize*size_mult

if potion_spr==spr_empty
{
	if recipe=="empty"
	{
		instance_destroy()
		exit
	}
	var allrecipe=potion_get_recipes()
	var dodel=true
	for (var i=0;i<array_length(allrecipe);i++)
	{
		if allrecipe[i].name==recipe
		{
			potion_datas=allrecipe[i]
			dodel=false
		}
	}
	if dodel{
		instance_destroy()
		exit
	}
	
	recipe_item= potion_datas.brew_into
	potion_spr=item_get_sprite(recipe_item)
	description=potion_get_recipe_text(potion_datas.recipe)
	my_name=potion_name_get_name(recipe)
	go_description=[my_name]
	go_description=array_concat(go_description,description)
}

if point_in_rectangle(mouse_x,mouse_y,bbox_left,bbox_top,bbox_right,bbox_bottom)
{
	on_mouse=true
	with(obj_brewery_item)
	{
		if held
		{
			other.on_mouse=false
		}
		if show_data
		{
			show_data=false
		}
	}
	if point_in_rectangle(mouse_x,mouse_y,x-8*size*0.8,y-8*size*0.8,x+8*size*0.8,y+8*size*0.8)
	{talk_potion=true}
	else
	{talk_potion=false}
}
else
{
	on_mouse=false
}