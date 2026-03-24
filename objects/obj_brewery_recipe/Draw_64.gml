image_xscale=size
image_yscale=size

draw_self()
var size_item=0.8
if talk_potion&&on_mouse
{
	gpu_set_fog(true,c_white,0,0)
	draw_item(x+1*size*size_item,y,recipe_item,size*size_item)
	draw_item(x-1*size*size_item,y,recipe_item,size*size_item)
	draw_item(x,y-1*size*size_item,recipe_item,size*size_item)
	draw_item(x,y+1*size*size_item,recipe_item,size*size_item)
	gpu_set_fog(false,c_white,0,0)
}
draw_item(x,y,recipe_item,size*size_item)

var l=array_length(go_description)
var starty=y+size*7
draw_set_halign(textalign_center)
draw_set_valign(textalign_top)
draw_set_font(fnt_nametag_subtext)
draw_set_colour(#57684E)
var textmult=0.12
for (var i=0;i<4;i++)
{
	if i<l && size>4
	{
		var text=go_description[i]
		if i==3
		{
			text="..."
		}
		draw_text_transformed(x,starty,go_description[i],size*textmult,size*textmult,0)
		if i==0{
			draw_text_ext_transformed_bold(x,starty,go_description[i],0,100000000,size*textmult,size*textmult,0)
		}
		starty+=size*3
	}
}

draw_set_halign(textalign_left)
draw_set_colour(c_black)

if on_mouse
{
	if talk_potion
	{
		draw_nametag_gui(item_get_name(recipe_item))
		item_draw_box_datas(recipe_item,device_mouse_x_to_gui(0)-8,device_mouse_y_to_gui(0)+65,3)
	}
	else
	{
		draw_nametag_gui(my_name)
		draw_box_datas(go_description,[],device_mouse_x_to_gui(0)-8,device_mouse_y_to_gui(0)+65,3)
	}
}