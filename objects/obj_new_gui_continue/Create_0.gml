// Inherit the parent event
event_inherited();
priority=1

name="Continue"

sprite_index=spr_ui_icon_continue
real_x=1320-size*10
real_y=40+size*10
active=false
open_up=function()
{
	if !active
	{
		room_goto(room_game)
		remove_ind()
		room_persistent=false
		remove_ind()

	}
	active=false

}

add_ind=function()
{
}