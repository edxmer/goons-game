global.goon_count--
if inventory!="empty"
{
	create_item(x,min(bbox_bottom+12,global.room_height-16),inventory)
}