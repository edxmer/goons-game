global.goon_edit_mode=true
global.special_coords=[global.goon_edit_id.x+15*global.camera_size,global.goon_edit_id.y-5*global.camera_size]
last_id=global.goon_edit_id
was_right_pressed=false
buttons_last=[]
selected_button_last=-1

selected_effects=true
selected_equipment=false
selected_inventory=false

health_size=1

draw_health=function(xx,yy,current,maxx,size,low_quality=false)
{
	var empty=spr_goon_health_empty
	var full=spr_goon_health_full
	var size_spr=size
	if low_quality
	{
		size_spr*=2
		empty=spr_goon_health_empty__halfhd1
		full=spr_goon_health_full_half_hd
	}
for (var i=0;i<maxx;i++)
{
	var spr=empty
	
	if i<current
	{
		spr=full
	}
	draw_sprite_ext(spr,0,xx+i*size*12,yy,size_spr,size_spr,0,c_white,1)

}

}