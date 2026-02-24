x=clamp_to_grid_start(mouse_x)
y=clamp_to_grid_start(mouse_y)

if !global.grid_mode
{
	instance_destroy()
}

if !instance_exists(obj_cursor_go_goons)
{

	global.gridmode_placeable=is_placeable_function(x,y+16,global.grid_mode_sprite)

}