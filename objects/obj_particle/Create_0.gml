subimg=0
sprite=spr_empty
size=irandom_range(3,5)
assigned=false
indy=0
indx=0
bonus=size div 2
x_velocity=random_range(3,-3)
y_velocity=random_range(-2,3)
z_velocity=random_range(-4,-2)
gravity_val=1

disappear=irandom_range(2,4)
alpha=1

z =-12

assign=function()
{
	assigned=true
	indy=irandom_range(sprite_get_bbox_top(sprite),sprite_get_bbox_bottom(sprite)-size)
	indx=irandom_range(sprite_get_bbox_left(sprite),sprite_get_bbox_right(sprite)-size)
	var height=sprite_get_bbox_bottom(sprite)-sprite_get_bbox_top(sprite)
	z=-irandom_range(height*0.75,height*1.5)
	

}