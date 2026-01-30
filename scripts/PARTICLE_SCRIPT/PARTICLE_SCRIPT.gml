function particle_summon_from_texture_one(xx,yy,sprite){
	xx-=sprite_get_xoffset(sprite)
	yy-=sprite_get_yoffset(sprite)
	xx+=irandom_range(sprite_get_bbox_left(sprite),sprite_get_bbox_right(sprite)-3)
	yy+=irandom_range(sprite_get_bbox_top(sprite),sprite_get_bbox_bottom(sprite)-3)
	var particle=instance_create_depth(xx,yy,depth,obj_particle)
	particle.sprite=sprite
}

function particle_summon_from_texture_multiple(xx,yy,sprite,amount)
{
	repeat(amount)
	{
		particle_summon_from_texture_one(xx,yy,sprite)
	}
}