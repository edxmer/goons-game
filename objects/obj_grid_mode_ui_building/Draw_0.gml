depth=-bbox_bottom
image_index=global.grid_mode_sprite
image_blend=c_white
if !global.gridmode_placeable
{
	image_blend=c_red
}
draw_self()