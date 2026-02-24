function summon_grid_ui_of_building(sprite=global.grid_mode_sprite)

{
	if (!instance_exists(obj_grid_mode_ui_building))
	{
		var idb=instance_create_depth(0,0,0,obj_grid_mode_ui_building)
		idb.sprite_index=sprite
	}
	else{
		with(obj_grid_mode_ui_building)
		{
			sprite_index=sprite
		}
	}

}
function clamp_to_grid_start(_coord_one)
{
	return (_coord_one>>4)*16

}
function clamp_to_grid_middle(_coord_one)
{
	return (_coord_one>>4)*16+8

}

function run_for_all_sprite_tile(xx,yy,sprite,func)
{
	var mid_x=sprite_get_xoffset(sprite)
	var start_x=sprite_get_bbox_left(sprite)-mid_x
	var end_x=sprite_get_bbox_right(sprite)-mid_x
	var mid_y=sprite_get_yoffset(sprite)
	var start_y=sprite_get_bbox_top(sprite)-mid_y
	var end_y=sprite_get_bbox_bottom(sprite)-mid_y
	var ret_val=true
	var funct_true=function(xxx,yyy){}
	funct_true=func
	for (var iy=start_y;iy<=end_y;iy+=16)
	{
		for (var ix=start_x;ix<=end_x;ix+=16)
		{
			ret_val=ret_val && funct_true(xx+ix,yy+iy)
		}
		if !ret_val
		{
			return false
		}
	}
		/*ret_val=ret_val && funct_true(xx+end_x,yy+iy)
	}
	for (var ix=start_x;ix<end_x;ix+=16)
	{
		ret_val=ret_val && funct_true(xx+ix,yy+end_y)
	}
	ret_val=ret_val && funct_true(xx+end_x,yy+end_y)*/
	return ret_val

}




function gridmode_check_ground_hitboxes(xx,yy,sprite)
{
	
	return run_for_all_sprite_tile(xx,yy,sprite,is_ground_placeable_pixel)
}
function gridmode_check_ground_hitboxes_farmland(xx,yy,sprite)
{
	
	return run_for_all_sprite_tile(xx,yy,sprite,is_ground_farmland_pixel)
}
function gridmode_check_workstation_hitboxes(xx,yy,sprite)
{

	return run_for_all_sprite_tile(xx,yy,sprite,is_pixel_not_meeting_workstation)

}

function is_pixel_not_meeting_workstation(xx,yy)
{
	var rx=clamp_to_grid_start(xx)
	var ry=clamp_to_grid_start(yy)
	return collision_rectangle(rx,ry,rx+16,ry+16,obj_work_station,false,true)==noone

}
function is_ground_farmland_pixel(xx,yy)
{
	return is_tile_farmland(floor(xx/16),floor(yy/16))
}
function is_ground_placeable_pixel(xx,yy)
{
	return is_tile_placeable(floor(xx/16),floor(yy/16))
}


function draw_grid(){
	
	var gridsize=16
	var startxx=global.cam.coords[0]
	var endxx=global.cam.coords_bottom[0]
	var startyy=global.cam.coords[1]
	var endyy=global.cam.coords_bottom[1]
	var startx=(global.cam.coords[0]-20)>>4
	var	starty=(global.cam.coords[1]-20)>>4
	var _endy=(global.cam.coords_bottom[1]+20)>>4
	var _endx=(global.cam.coords_bottom[0]+20)>>4
	var size=global.camera_size
	var dark_colour=#101119
	draw_set_colour(dark_colour)
	draw_set_alpha(0.7)
	for (var i=starty;i<_endy;i++)
	{
		
		draw_rectangle(startxx,i*16-0.3,endxx,i*16+0.3,false)
	}
	for (var i=startx;i<_endx;i++)
	{
		
		draw_rectangle(i*gridsize-0.3,startyy,i*gridsize+0.3,endyy,false)
	}
	draw_set_alpha(1)
}