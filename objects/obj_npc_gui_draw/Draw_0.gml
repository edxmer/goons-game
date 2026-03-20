if array_length(global.npc_data.room_tiles_below)==0
{
	exit
}

var change_mod=change_modifier_npc/change_modifier_npc_max
var change_mod_sec=change_modifier_npc_second/change_modifier_npc_max
	
var cam = view_camera[0]
var view_x = camera_get_view_x(cam)
var view_y = camera_get_view_y(cam)
var scale_x = camera_get_view_width(cam)  / display_get_gui_width()
var scale_y = camera_get_view_height(cam) / display_get_gui_height()



for (var i=0;i<array_length(global.npc_data.room_tiles_below);i++)
{
	var tile=global.npc_data.room_tiles_below[i]
	var xx = view_x + tile.x_coord * scale_x
	var yy = view_y + tile.y_coord * scale_y
	var  size=tile.size
	var size_base=max(min(size,1),size*(1-change_mod))
	size = size_base * scale_x  // assuming uniform scale
	

	var spr=tile.sprite_id
	
	
	draw_sprite_ext(spr,floor((current_time/1000)*sprite_get_speed(spr))%sprite_get_number(spr),xx,yy,size,size,0,c_white,1)
}