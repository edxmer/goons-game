
size=4
distance_y=20*size
draw_set_colour(#101119)
draw_set_alpha(0.2)
draw_rectangle(x-40*size,y-20*size,x+40*size,y+distance_y*array_length(saves)*size+20*size,false)
draw_set_alpha(1)
draw_rectangle(x-40*size,y-20*size,x+40*size,y+distance_y*array_length(saves)*size+20*size,true)
draw_set_alpha(1)
hitboxy=(sprite_get_bbox_bottom(spr_button_paper)-sprite_get_bbox_top(spr_button_paper))*size>>1
hitboxx=(sprite_get_bbox_right(spr_button_paper)-sprite_get_bbox_left(spr_button_paper))*size>>1
for (var i=0;i<array_length(saves);i++)
{
	var savename=saves[i]
	
	var yy=y+i*distance_y
	var iconind=0
	var ind=0
	var xplus=0
	var nowselected=false
	if point_in_rectangle(mouse_x,mouse_y,x-hitboxx,yy-hitboxy,x+hitboxx,yy+hitboxy)
	{
		nowselected=true
		ind=1
		xplus=4*size
		if selected_index==i
		{
			ind=2
			iconind=1
			if savename==newgame{
				iconind=2
			}
			xplus=12*size
		}
		else
		{
			sound_play_category_at("swoosh",x,y)
		}

	}
	if !nowselected && selected_index==i
	{sound_play_category_at("swoosh",x,y)
	selected_index=-1
		}
	draw_sprite_ext(spr_button_paper,ind,x,yy,size,size,0,c_white,1)
	draw_sprite_ext(spr_button_paper_icons,iconind,x,yy,size,size,0,c_white,1)
	if nowselected{
		selected_index=i
	}
	draw_set_font(fnt_nametag)
	draw_set_halign(textalign_center)
	draw_set_valign(textalign_middle )
	draw_set_colour(#101119)
	draw_text_ext_transformed(x+xplus-4*size,yy-size*3.5,savename,1.2,1000*size,size*0.2,size*0.2,0)
	
	
	draw_set_halign(textalign_left)
	draw_set_valign(textalign_top )
}