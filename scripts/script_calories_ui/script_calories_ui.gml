function draw_calories_meter_base(startx,starty,px_length){
	var size=global.camera_size
	draw_sprite_ext(spr_calorie_meter_outside_start,0,startx,starty,size,size,0,c_white,1)
	for (var i=0;i<ceil(px_length/2);i++)
	{
		draw_sprite_ext(spr_calorie_meter_outside_middle,0,startx,starty,size,size,0,c_white,1)
		startx+=size*2
	}
	startx-=(size*4)
	draw_sprite_ext(spr_calorie_meter_outside_end,0,startx,starty,size,size,0,c_white,1)
}

function draw_calories_objective(xx,yy,item_id,outline_id){
		var size=global.camera_size
		draw_sprite_ext(spr_calorie_meter_objectives,outline_id,xx,yy,size,size,0,c_white,1)
		draw_item(xx+0.5*size,yy+0.5*size,item_id,size*0.6)
}

function draw_calories_meter_inside(startx,starty,px_length,percent){
	if percent>0{
		var size=global.camera_size
		px_length*=percent
		px_length-=4
		startx+=1*size
	
		draw_sprite_ext(spr_calorie_meter_inside_start,0,startx,starty,size,size,0,c_white,1)
		for (var i=0;i<ceil(px_length/2);i++)
		{
			draw_sprite_ext(spr_calorie_meter_inside_middle,0,startx,starty,size,size,0,c_white,1)
			startx+=size*2
		}
		startx-=(size*3)
		draw_sprite_ext(spr_calorie_meter_inside_end,0,startx,starty,size,size,0,c_white,1)
	}
}

function draw_calories_objectives(startx,starty,px_length)
{
	var size=global.camera_size
	var yy=starty
	var xx=startx+10*size
	var current="empty"
	var calobj_length=array_length(global.current_calorie_objectives)
	for (var i=0;i<(calobj_length+array_length(global.current_calorie_cravings));i++)
	{
		var id_no=0
		if i<calobj_length
		{
			current=global.current_calorie_objectives[i].item_id
			if global.current_calorie_objectives[i].done
			{
				id_no=1
			}

		}
		else
		{
			current=global.current_calorie_cravings[i-calobj_length].item_id
			id_no=2
			/*if current.done 
			{
				id_no=1
			}*/
		}


		draw_calories_objective(xx,yy,current,id_no)
		xx+=20*size
		if (xx-startx-20*size)/size>px_length
		{
			xx=startx
			yy+=20*size
		}
	}

}

function draw_calories_meter(px_length)
{
	
	var size=global.camera_size
	var startx=global.cam.coords[0]+20*size
	var starty=global.cam.coords[1]+17*size
	draw_calories_meter_base(startx,starty,px_length)
	var percent=min(1,global.current_calories/max(1,global.needed_calories))
	draw_calories_meter_inside(startx,starty,px_length,percent)
	draw_calories_objectives(startx+8*size,starty+12*size,px_length-8*size)

}


