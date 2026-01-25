function draw_item_outlined(item_id,_x,_y,outline_id,size=1){
	draw_sprite_ext(spr_outline,outline_id,_x,_y,1.5,1.5,0,c_white,0.8)
	draw_item(_x,_y,item_id,1.5*size)
}

function draw_workstation_outlined(work_station,_x,_y,outline_id,size=1){
	draw_sprite_ext(spr_outline,outline_id,_x,_y,1.5*size,1.5*size,0,c_white,0.8)
	draw_item(_x,_y,work_station,0.75*size)
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
	start_y+=3*30
	draw_summon_information(_x,start_y,summon_list)

}