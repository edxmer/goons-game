// Inherit the parent event
if array_length(inventory)>0
{
	draw_item(x+8*image_xscale,y+8*image_yscale+abs((image_index)-2)*3-6,inventory[0],1)
}

event_inherited();

