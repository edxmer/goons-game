function create_enemy(xx,yy,enemy_obj_index){
	return instance_create_depth(xx,yy,0,enemy_obj_index)
}

function enemy_locate_object(enemy_id,object_id)
{
	if instance_exists(object_id)
	{
		enemy_id.x=object_id.x
		enemy_id.y=object_id.y
		return true
	}
	return false
}

function search_for_nearest_item_with_calories(xx,yy)
{
	var closest_curr=10000000
	var current_closest_id=noone
	with (obj_item)
	{
		if item_get_calories(item_id)>0
		{
			if point_distance(x,y,xx,yy)<closest_curr
			{
				closest_curr=point_distance(x,y,xx,yy)
				current_closest_id=id
			}
		}
	}
	return current_closest_id
}

function pickuppable_enemies(px,py,pickup_distance=35)
{
	var en_items=[]
	with(obj_enemy_parent)
	{
		if !(array_contains(tags,"danger") &&global.goon_count==1){
		
		
			var dist=point_distance(x,y,px,py)
			
			if dist<=pickup_distance  && array_contains(tags,"pickuppable"){
				array_push(en_items,[id,dist,item_to_be_turned_into,"enemy",[]])
			}
		}
	}
	return en_items
}

function enemy_picked_up(en_id)
{
	en_id.picked_up_script()
}