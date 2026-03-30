draw_sprite_ext(sprite_index,on_mouse,real_x,show_y,size,size,0,c_white,1)
var size_real=size
size=size*signs_size_mult
if active{
	var yy=show_y+18*size

	draw_set_halign(textalign_center)
	draw_set_valign(textalign_middle)
	draw_set_colour(c_black)
	draw_set_font(	fnt_nametag)
	for (var i=0;i<array_length(signs);i++)
	{
	
		var sdata=signs[i]
	
		var spr=sdata.spr
		var minusx=5*size
		if sdata.small
		{
		minusx=15*size
		
		}
		draw_sprite_ext(spr,i==sign_selected,real_x,yy,size,size,0,c_white,1)
		draw_sprite_ext(signs[i].icon,i==sign_selected,real_x,yy,size,size,0,c_white,1)
		draw_text_ext_transformed(real_x-minusx,yy+4*size,signs[i].name,100,100000000,size*text_mult,size*text_mult,0)
		yy+=sign_size*size
	}
	draw_set_halign(textalign_top)
	draw_set_valign(textalign_left)



}
size=size_real
if on_arrows
{
	draw_sprite_ext(spr_ui_icon_arrows_up,on_up,real_x,show_y,size,size,0,c_white,0.6+0.2*on_up+0.2*(!on_mouse))
	draw_sprite_ext(spr_ui_icon_arrows_down,on_down,real_x,show_y,size,size,0,c_white,0.6+0.2*on_down+0.2*(!on_mouse))
}
