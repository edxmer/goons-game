global.goon_edit_mode=true
global.special_coords=[global.goon_edit_id.x,global.goon_edit_id.y]
last_id=global.goon_edit_id
was_right_pressed=false
buttons_last=[]
selected_button_last=-1

selected_effects=true
selected_equipment=false
selected_inventory=false

health_size=1

draw_health=function(xx,yy,current,maxx,size)
{
for (var i=0;i<maxx;i++)
{
	var spr=spr_goon_health_empty
	
	if i<current
	{
		var spr=spr_goon_health_full
	}
	draw_sprite_ext(spr,0,xx+i*size*13,yy,size,size,0,c_white,1)

}

}