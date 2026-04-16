function get_enemies_in_rotated_box(cx, cy, hw, hh, angle, target_objects)
{
    var result = []
    var cos_a = dcos(angle)
    var sin_a = dsin(angle)
    with (target_objects)
    {
        var dx = x - cx
        var dy = y - cy
        var local_x = dx * cos_a - dy * sin_a
        var local_y = dx * sin_a + dy * cos_a
        if abs(local_x) <= hw && abs(local_y) <= hh
        {
            array_push(result, id)
        }
    }
    return result
}


function hurt_instance(_id,amount,special_invincibility=undefined)
{

	if !instance_exists(_id)
	{
		return
	}
	if is_undefined(special_invincibility)
	{
		special_invincibility=_id.invincible_sec
	}
	if _id.object_index==obj_goon
	{
		hurt_goon(_id,amount)
	}
	else if object_is_ancestor(_id.object_index,obj_enemy_parent)
	{
		hurt_enemy(_id,amount)
	}

}


function create_hurt_object(hurt_object_index,xx,yy,rotation,damage,size)
{
	if object_is_ancestor(hurt_object_index,obj_hurtbbox_parent)
	{
		var hurt=instance_create_depth(xx,yy,0,hurt_object_index)
		hurt.rotation=rotation
		hurt.damage=damage
		hurt.size=size
		hurt.load_real()
		return hurt
	}
	return noone
}