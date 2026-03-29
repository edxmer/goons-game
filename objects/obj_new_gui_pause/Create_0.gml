// Inherit the parent event
event_inherited();
priority=1
sprite_index=spr_ui_icon_pause
real_x=1220
real_y=100
active=false
open_up=function()
{
	if !active
	{
		goto_extension_room_main_menu(room_pause_menu)

	}
	active=false

}
