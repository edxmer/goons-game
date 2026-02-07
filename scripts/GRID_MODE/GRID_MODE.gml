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