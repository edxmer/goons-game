// Inherit the parent event
event_inherited();
priority=1
sprite_index=spr_ui_icon_continue
real_x=1220
real_y=100
active=false
open_up=function()
{
	if !active
	{
		room_goto(room_game)
		room_persistent=false

	}
	active=false

}
goto_extension_room_main_menu(room_pause_menu)