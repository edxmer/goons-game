hurtgoons=false
hurtenemy=true
damage=1
has_hitbox=true
lifetime_seconds=1
lived_already=0
alphas=[0.8,0.6]
alpha_count=2
alpha_onestage=lifetime_seconds/alpha_count
alpha_current=alphas[0]
size=1
rotation=0
image_count=sprite_get_number(sprite_index)
image_onestage=lifetime_seconds/image_count
image_current=0

size_width=((bbox_right-bbox_left)/2)*size
size_height=((bbox_bottom-bbox_top)/2)*size


point_mid_y=(bbox_bottom+bbox_top)/2
point_mid_x=(bbox_right+bbox_left)/2
box_distace=point_distance(x,y,bbox_left,bbox_top)*size

	box_start_rot=point_direction(x,y,point_mid_x,point_mid_y)
real_bbox_left=x+lengthdir_x(box_distace,box_start_rot+rotation)
real_bbox_top=y+lengthdir_y(box_distace,box_start_rot+rotation)

hurt_function=function(_id)
{
	hurt_instance(_id,damage)
}

load_real=function()
{
	alpha_count=array_length(alphas)
	image_count=sprite_get_number(sprite_index)
	image_onestage=lifetime_seconds/image_count

	image_current=0
	
	alpha_count=2
	alpha_onestage=lifetime_seconds/alpha_count
	alpha_current=alphas[0]
	
	image_xscale=size
	image_yscale=size
	
	size_width=(bbox_right-bbox_left)/2
	size_height=(bbox_bottom-bbox_top)/2
		
	point_mid_y=(bbox_bottom+bbox_top)/2
	point_mid_x=(bbox_right+bbox_left)/2
	
	box_distace=point_distance(x,y,point_mid_x,point_mid_y)
	box_start_rot=point_direction(x,y,point_mid_x,point_mid_y)
	
	real_bbox_left=x+lengthdir_x(box_distace,box_start_rot+rotation)
	real_bbox_top=y+lengthdir_y(box_distace,box_start_rot+rotation)

}

load_real()