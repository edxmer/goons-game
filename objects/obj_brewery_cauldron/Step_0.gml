potion_step=floor((current_time/300))%3
image_xscale=scale
image_yscale=scale


if scale<7
{
	scale++
}

if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,obj_brewery_item,false,true)
{
	var _dropped=false
	var size=scale
	with (obj_brewery_item)
	{
		if point_in_rectangle(x,y,other.bbox_left,other.bbox_top,other.bbox_right,other.bbox_bottom) && !held && motion_y>0 && !dropped
		{
			_dropped=true
			other.dropped_x=clamp(x-(other.bbox_left+other.bbox_right)/2,-10*size,10*size)
			other.dropped_time=current_time
			other.potion_item=item_id
			array_push(global.npc_room_transfer_items_to_destroy,item_id)
			dropped=true
		}
	}
	if _dropped
	{
		
		sound_play_category_at("water_splash",(bbox_left+bbox_right)/2,y)
		repeat 2
		{
			potion_color=colors_blend(potion_color,sprite_get_average_color(item_get_sprite(potion_item)))
		}
		drop_item(potion_item)

		splash=true
		
	}
}

