draw_shadow_param(x+rot_diff_x,ground+size*8+z,clamp(size-abs((y+rot_diff_y-ground))*size/(20*size),0,size))
draw_sprite_ext(sprite_active,sprite_get_current_subimg(sprite_active),x+rot_diff_x,y+rot_diff_y,size,size,rotation,c_white,1)

