startx=70
size=7
plusx=14*size

width_max=room_width-32*7

var itemslength=array_length(global.npc_room_nearby_items)
plusx=min(width_max/itemslength,plusx)

startx=(width_max-plusx*itemslength)*0.5

for (var i=0;i<array_length(global.npc_room_nearby_items);i++)
{
	y=irandom_range(100,180)
	var item=instance_create_layer(startx,y,"Instances_above",obj_brewery_item)
	item.item_id=global.npc_room_nearby_items[i]
	startx+=plusx-irandom_range(-2,0)
}
instance_destroy()