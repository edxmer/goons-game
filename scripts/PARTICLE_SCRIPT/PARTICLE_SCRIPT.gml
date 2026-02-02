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

function is_on_snow(_x,_y)
{
	var l_id=layer_tilemap_get_id("ground_layer")
	return array_contains([3,4,6,12,14,17],tilemap_get_at_pixel(l_id,_x,_y))

}

function particle_footstep(_x,_y,_particle_sprite=spr_particle_footstep)
{
	_x=round(_x)+irandom_range(-4,4)
	_y=round(_y)+irandom_range(-2,0)
	if !is_on_snow(_x,_y)
	{
	return
	}
//particle_footstep
var _ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
var _ptype1 = part_type_create();
part_type_sprite(_ptype1, _particle_sprite, false, false, true)
part_type_size(_ptype1, 1, 1, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 0, 0, 0, 0);
part_type_direction(_ptype1, 80, 100, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 0.078);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 1000, 1000);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, 0,0,0, 0, ps_shape_rectangle, ps_distr_linear);
part_emitter_burst(_ps, _pemit1, _ptype1, 1);

part_system_position(_ps, _x, _y);


}