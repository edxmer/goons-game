if size<7 && !dropped
{
	size++
}
if sprite==spr_empty
{
	if item_id=="empty"
	{
		instance_destroy()
		exit
	}
	groundsound=item_get_ground_sound(item_id)
	sprite=item_get_sprite(item_id)
	sprite_held=item_get_held_sprite(item_id)
}

  image_xscale=size
image_yscale=size
ground=680
var dt=delta_time/1000000

if y<200+10*size
{
	ground=200
}
if held 
{
	show_data=false
	
	sprite_active=sprite_held
	motion_x=(mouse_x+x_plus-x)*2*size+motion_x*0.5
	motion_y=(mouse_y+y_plus-y)*2*size+motion_y*0.5
	x=mouse_x+x_plus
	y=mouse_y+y_plus

	x=clamp(x,5*size,room_width-5*size)
	y=clamp(y,5*size,room_height-5*size)
	rotation+=motion_x*dt*-0.5
	rotation=rotation- (rotation-rot_start)*0.05
	rotation=clamp(rotation,rot_start-60,rot_start+60)
	


	if (y_plus < -3*size)
	{

	    y_plus+=1*size
	}
	
	
	/*var look=point_direction(mouse_x,mouse_y,x,y)
	var ds=point_distance(mouse_x,mouse_y,x,y)
	look+=rot_start-rotation
	var shouldbex=lengthdir_x(ds,look)+mouse_x
	var shouldbey=lengthdir_y(ds,look)+mouse_y
	var dist=point_distance(x,y,shouldbex,shouldbey)
	look=point_direction(x,y,shouldbex,shouldbey)
	rot_diff_x=lengthdir_x(dist,look)
	rot_diff_y=lengthdir_y(dist,look)*/
	var grab_dist = point_distance(0, 0, -x_plus, -y_plus)
	var grab_ang  = point_direction(0, 0, -x_plus, -y_plus);
	var rot_delta = rotation - rot_start;

	var draw_x = mouse_x - lengthdir_x(grab_dist, grab_ang + rot_delta);
	var draw_y = mouse_y - lengthdir_y(grab_dist, grab_ang + rot_delta);

	rot_diff_x = draw_x - x;
	rot_diff_y = draw_y - y;
	//x=clamp(x+rot_diff_x,5*size,room_width-5*size)-rot_diff_x
	//y=clamp(y+rot_diff_x,5*size,room_height-5*size)-rot_diff_y
	if !mouse_check_button(mb_left) 
	{
		held=false
		x+=rot_diff_x
		y+=rot_diff_y
		if abs(y-ground)<=5*size
		{
			sound_play_category_at(groundsound,x,y)
		}
	}
	
}
else
{
	rot_diff_x=0
	rot_diff_y=0
	sprite_active=sprite
	if abs(y-ground)>5*size
	{
		on_ground=false
		motion_y+=grav
	}
	
	if !on_ground
	{
		y+=motion_y*dt
	}
	if y>ground && !on_ground && motion_y>=0
	{
		y=ground+irandom(4)
		motion_y=0
		sound_play_category_at(groundsound,x,y)
		on_ground=true
	}
	if on_ground
	{
		if y<(ground+z)
		{
			y+=min(10,	(ground+z)-y)
		}
		
		motion_x*=0.8
		if abs(motion_x)<0.1
		{
			motion_x=0
		}
		
		rotation%=360
		rotation+=720
		rotation%=360
		var smrot=rotation%90
		if !is_value_between(smrot,0,30)&& !is_value_between(smrot,90,60) 
		{
			var val1=sign(motion_x)*10
			var val2=motion_x/0.8-motion_x
			if abs(val1)<abs(val2)
			{
				motion_x+=val2
			}
			else
			{
				motion_x+=val1
			}
			/*if smrot<45
			{
				var gurul=-rotation*0.2
				if motion_x>-gurul*10
				{
					motion_x+=gurul*10
				}
				else
				{
					motion_x-=gurul*10
				}
				rotation-=gurul
			}
			else
			{
				var gurul=(360-rotation)*0.2
				if motion_x<-gurul*10
				{
					motion_x-=gurul*10
				}
				else
				{
					motion_x+=gurul*10
				}
				rotation-=gurul
			}*/
		
		}
	}
	x+=motion_x*dt
	rotation+=motion_x*dt*-0.5
	if x<0 || x>room_width
	{
		sound_play_category_at(groundsound,x,y)
		motion_x*=-1
		x=clamp(x,5*size,room_width-5*size)
	}
	if y<0 || y>room_height
	{
		if motion_y<0
		{
			motion_y*=-0.6
		}
		y=clamp(y,5*size,ground)
	}
	
	if point_in_rectangle(mouse_x,mouse_y,x-size*8,y-size*8,x+size*8,y+size*8)
	{
		var me=true
		var metoo=true
		with (obj_brewery_item)
		{
			if held
			{
				me=false
				metoo=false
			}
			if show_data
			{
				metoo=false
			}
		}
		if mouse_check_button_pressed(mb_left)
		{
			
			if me || show_data
			{
				if show_data
				{
					with(obj_brewery_item)
					{
						held=false
					}
				}
				x_plus=x-mouse_x
				y_plus=y-mouse_y
				motion_x=0
				motion_y=0
				rot_start=rotation
				held=true
				sound_play_category_at("pickup",x,y)
			}
		}
		else
		{

			if metoo && !held
			{

				show_data=true
			}
		
		}
	}
	else
	{
		show_data=false
	}
	
	
}


if dropped
{
	motion_x*=0.1
	motion_y*=0.1
	size--
	if size<=0
	{
		if array_contains(item_get_tags(item_id),"persistent_brewery")
		instance_create_layer(x,0,layer,obj_brewery_item).item_id=item_id
		instance_destroy()
	}
}