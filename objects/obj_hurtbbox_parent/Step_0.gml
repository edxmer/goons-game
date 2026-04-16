if lifetime_seconds<=lived_already
{
	instance_destroy()
	exit
}

image_current=clamp(floor(lived_already/image_onestage),0,image_count-1)

if alpha_count>1
{
	alpha_stat=lived_already/alpha_onestage
	alpha_base=clamp(floor(alpha_stat),0,alpha_count-1)
	alpha_up=clamp(ceil(alpha_stat),0,alpha_count-1)

	alpha_change=(alpha_stat-alpha_base)
	alpha_current=alphas[alpha_base]*(1-alpha_change)+alphas[alpha_up]*alpha_change
}
lived_already+=delta_time/1000000

if has_hitbox
{	
	var enemies=[]
	if hurtgoons
	{
		enemies=get_enemies_in_rotated_box(real_bbox_left, real_bbox_top, size_width,size_height , rotation,obj_goon)
		
	}
	if hurtenemy
	{
		enemies=array_concat(enemies,get_enemies_in_rotated_box(real_bbox_left, real_bbox_top, size_width,size_height , rotation,obj_enemy_parent))
	}
	for (var i=0;i<array_length(enemies);i++)
	{
		
		hurt_function(enemies[i])
	}
}
