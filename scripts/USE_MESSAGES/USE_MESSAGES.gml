function draw_item_outlined(item_id,_x,_y,outline_id,size=1){
	draw_sprite_ext(spr_outline,outline_id,_x,_y,1.5*size,1.5*size,0,c_white,0.8)
	draw_item(_x,_y,item_id,1.5*size)
}

function draw_nametag(name){
	var size=global.camera_size*0.6
	var startx=mouse_x+30*size
	var starty=mouse_y-3*size
	
	draw_set_font(fnt_nametag)
	draw_set_halign(textalign_left)
	draw_set_valign(textalign_middle )
	draw_set_colour(#101119)
	var length=max(1,((string_width(name)/3.5) -22))
	
	if global.cam.coords_bottom[0]<(startx+(length+12)*size)
	{
		startx=mouse_x-(20+length)*size
	}
	if global.cam.coords_bottom[1]<starty+12*size
	{
		starty=global.cam.coords_bottom[1]-12*size
	}
	else if global.cam.coords[1]+12*size>starty
	{
		starty=global.cam.coords[1]+12*size
	}
	
	draw_sprite_ext(spr_nametag_begin,0,startx,starty,size,size,0,c_white,1)
	
	for  (var i=0;i<length;i++)
	{
		draw_sprite_ext(spr_nametag_middle,0,startx+i*size*1,starty,size,size,0,c_white,1)
	}
	draw_sprite_ext(spr_nametag_end,0,startx+(length-1)*size*1,starty,size,size,0,c_white,1)
	
	startx-=8*size

	starty-=3.5*size
	draw_text_ext_transformed(startx,starty,name,1.2,1000*size,size*0.2,size*0.2,0)
	draw_set_halign(textalign_left)
	draw_set_valign(textalign_top )
}


function draw_workstation_outlined(work_station,_x,_y,outline_id,size=1){

	draw_sprite_ext(spr_outline,outline_id,_x,_y,1.5*size,1.5*size,0,c_white,0.8)
	draw_workstation(_x,_y,work_station,0.75*size)
}

function draw_craft_arrow(_x,_y){
	draw_sprite_ext(spr_arrow_down,current_second%4,_x,_y,1.2,1.2,0,c_white,0.8)
}


function draw_craft_information(_x,_y,craft_input_list,craft_output_list)
{
	var space_input=(array_length(craft_input_list)-1)*1.5*30
	var space_output=space_input=(array_length(craft_output_list)-1)*1.5*30
	var space_max=max(space_input,space_output)
	var startx=clamp(_x-(space_max /2),space_max,room_width-space_max)
	var start_y=clamp(_y,30,room_height-1.5*30)
	
	var firstrow_x=_x-(space_input div 2)
	for (var i=0;i<array_length(craft_input_list);i++)
	{
		draw_item_outlined(craft_input_list[i],firstrow_x,start_y,0)
		firstrow_x+=30*1.5
	}
	start_y+=20*1.5
	
	start_y+=20*1.5
	firstrow_x=_x-(space_output / 2)
	for (var i=0;i<array_length(craft_output_list);i++)
	{
		draw_item_outlined(craft_output_list[i],firstrow_x,start_y,1)
		firstrow_x+=30*1.5
	}
	start_y-=20*1.5
	draw_craft_arrow(_x,start_y)

}

function draw_summon_information(_x,_y,summon_list)
{
	var space_input=(array_length(summon_list)-1)*1.5*30

	var startx=clamp(_x,space_input,room_width-space_input)
	var start_y=clamp(_y,30,room_height-30)
	
	var firstrow_x=_x-(space_input div 2)
	for (var i=0;i<array_length(summon_list);i++)
	{
		draw_item_outlined(summon_list[i],firstrow_x,start_y,2)
		firstrow_x+=30*1.5
	}


}


function draw_both_information(_x,_y,craft_input_list,craft_output_list,summon_list)

{
	var start_y=clamp(_y,30,room_height-3*30)
	draw_craft_information(_x,start_y,craft_input_list,craft_output_list)
	start_y+=3*40
	draw_summon_information(_x,start_y,summon_list)

}