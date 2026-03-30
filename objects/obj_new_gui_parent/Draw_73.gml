if active && sign_selected!=-1
{
	var ssign=signs[sign_selected]
	if ssign.whoarrow.has
	{
		var subimg=sprite_get_current_subimg(spr_goon_arrow_ui)
		with (obj_goon)
		{
			if ssign.whoarrow.func(id)
			{
				draw_sprite_ext(spr_goon_arrow_ui,subimg,x,y,1,1,0,c_white,1)
			}
		}
	}
	
}