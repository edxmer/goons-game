// Inherit the parent event
event_inherited();
priority=1

name="Pause"

sprite_index=spr_ui_icon_pause
real_x=1320-size*10
real_y=40+size*10
active=false
open_up=function()
{
	if !active
	{
		goto_extension_room_main_menu(room_pause_menu)

	}
	active=false

}
