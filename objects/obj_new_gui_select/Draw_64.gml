// Inherit the parent event
event_inherited();
if active{
var size_real=size
size=size*signs_size_mult
var yy=show_y+18*size
draw_sprite_ext(spr_ui_icon_button_slider_bckground,slider_selected,real_x,yy,size,size,0,c_white,1)
{
	draw_set_colour(#CDD651)
	draw_set_alpha(1)
	if slider_selected
	{
	draw_set_colour(#EDEF51)
	}

	draw_rectangle(real_x-4*size,slider_yy,real_x+8*size,show_y+20*size+30*size,false)
	draw_set_colour(#648746)
	if slider_selected
	{
	draw_set_colour(#73AA42)
	}
	draw_rectangle(real_x-4*size,show_y+20*size+29*size,real_x+8*size,show_y+20*size+30*size,false)
	draw_rectangle(real_x-4*size,slider_yy,real_x+3*size,show_y+20*size+30*size,false)
	draw_set_colour(#F1FF7A)
	if slider_selected
	{
	draw_set_colour(#F8FFC1)
	}
	draw_rectangle(real_x+5*size,slider_yy,real_x+8*size,show_y+20*size+30*size,false)
}
draw_sprite_ext(spr_ui_icon_button_slider,slider_selected,real_x,yy,size,size,0,c_white,1)
draw_sprite_ext(spr_ui_icon_button_slider_button,slider_selected,real_x+4*size,slider_yy,size,size,0,c_white,1)



draw_sprite_ext(spr_ui_icon_button_slider_button_options,option_hover,real_x,yy,size,size,0,c_white,1)
draw_set_halign(textalign_center)
draw_set_valign(textalign_middle)
draw_set_colour(c_black)
draw_text_ext_transformed(real_x+4*size,yy+42*size,options_text,100,100000000,size*text_mult,size*text_mult,0)
draw_set_halign(textalign_left)
draw_set_valign(textalign_top)

if show_options
{
	draw_sprite_ext(options_changes_current.sprite,option_change_hover,real_x,yy+4*sign_size*size,size,size,0,c_white,1)
	if mark_only_id!=-1
	{
		draw_sprite_ext(spr_ui_icon_button_option_mark_only,mark_selected+(mark_selected&&mouse_check_button(mb_left)),real_x,mark_only_yy,size,size,0,c_white,0.6+mark_selected*0.4)
	}
}


size=size_real
}