draw_sprite_ext(sprite_index,on_mouse,real_x,real_y,size,size,0,c_white,1)
if active{
var yy=real_y+20*size

draw_set_halign(textalign_center)
draw_set_valign(textalign_middle)
draw_set_colour(c_black)
draw_set_font(	fnt_nametag)
for (var i=0;i<array_length(signs);i++)
{
	draw_sprite_ext(spr_ui_icon_button,i==sign_selected,real_x,yy,size,size,0,c_white,1)
	draw_text_ext_transformed(real_x,yy+4*size,signs[i].name,100,100000000,size*text_mult,size*text_mult,0)
	yy+=sign_size*size
}
draw_set_halign(textalign_top)
draw_set_valign(textalign_left)
}