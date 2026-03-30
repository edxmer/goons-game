draw_sprite_ext(sprite_index,on_mouse,real_x,real_y,size,size,0,c_white,1)
if active{
	var yy=real_y+18*size

	draw_set_halign(textalign_center)
	draw_set_valign(textalign_middle)
	draw_set_colour(c_black)
	draw_set_font(	fnt_nametag)
	for (var i=0;i<array_length(signs);i++)
	{
	
		var sdata=signs[i]
	
		var spr=spr_ui_icon_button
		var minusx=5*size
		if sdata.small
		{
		spr=spr_ui_icon_button_small
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
