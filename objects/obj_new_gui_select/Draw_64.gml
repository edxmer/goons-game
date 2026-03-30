// Inherit the parent event
event_inherited();
if active{
var yy=real_y+18*size
draw_sprite_ext(spr_ui_icon_button_slider_bckground,slider_selected,real_x,yy,size,size,0,c_white,1)
{
	draw_set_colour(#CDD651)
	draw_set_alpha(1)
	if slider_selected
	{
	draw_set_colour(#EDEF51)
	}

	draw_rectangle(real_x-4*size,slider_yy,real_x+8*size,real_y+20*size+30*size,false)
	draw_set_colour(#648746)
	if slider_selected
	{
	draw_set_colour(#73AA42)
	}
	draw_rectangle(real_x-4*size,real_y+20*size+29*size,real_x+8*size,real_y+20*size+30*size,false)
	draw_rectangle(real_x-4*size,slider_yy,real_x+3*size,real_y+20*size+30*size,false)
	draw_set_colour(#F1FF7A)
	if slider_selected
	{
	draw_set_colour(#F8FFC1)
	}
	draw_rectangle(real_x+5*size,slider_yy,real_x+8*size,real_y+20*size+30*size,false)
}
draw_sprite_ext(spr_ui_icon_button_slider,slider_selected,real_x,yy,size,size,0,c_white,1)
draw_sprite_ext(spr_ui_icon_button_slider_button,slider_selected,real_x+4*size,slider_yy,size,size,0,c_white,1)
}