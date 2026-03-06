

function item_selected_draw_box_datas(item_id,size)
{
	if global.gui_nametag_called_last
	{
		return
	}
	var startx=mouse_x+15*size
	var starty=mouse_y+4*size
	item_draw_box_datas(item_id,startx,starty,size)
}
function item_get_effect_tags(item_id)
{
	var tags=item_get_tags(item_id)
	var ef_tags=[]
	for (var i=0;i<array_length(tags);i++)
	{
		var tag=tags[i]
		if string_starts_with(tag,"eq_")
		{
			array_push(ef_tags,string_copy(tag,4,string_length(tag)-3))
		}
		else
		{
			array_push(ef_tags,tag)
		}
	}
	if is_item_craving(item_id)
	{
		array_push(ef_tags,"craving")
	}
	if is_item_needed_calorie_objective(item_id)
	{
		array_push(ef_tags,"calorie_objective")
	}
	return ef_tags
}


function item_draw_box_datas(item_id,startx,starty,size)
{
	var calories_text=string(item_get_calories(item_id))+" kcal"
	var tags=item_get_effect_tags(item_id)
	
	draw_box_datas([calories_text],tags,startx,starty,size,3,spr_textbox)
}
function item_draw_box_datas_for_goon_ui_width_and_height(item_id,startx,starty,size,firstline="")
{
	var name_text=item_get_name(item_id)
	var calories_text= string(item_get_calories(item_id))+" kcal"
	var tags=item_get_effect_tags(item_id)
	var txtbox=[name_text,calories_text]
	if firstline!=""
	{
		array_insert(txtbox,0,firstline)
	}
	return draw_box_data_get_width_and_height(txtbox,tags,startx,starty,size,3,spr_textbox)
}

function item_draw_box_datas_for_goon_ui(item_id,startx,starty,size,firstline="",selected=false)
{
	var boxtexture=spr_textbox
	if selected
	{
		boxtexture=spr_textbox_selected_true
	}
	var name_text=item_get_name(item_id)
	var calories_text= string(item_get_calories(item_id))+" kcal"
	var tags=item_get_effect_tags(item_id)
	var txtbox=[name_text,calories_text]
	if firstline!=""
	{
		array_insert(txtbox,0,firstline)
	}
	draw_box_datas(txtbox,tags,startx,starty,size,3,boxtexture)
}


function draw_box_data_get_width_and_height(stringbox,effect_list,startx,starty,size,max_effects_in_oneline=3,spr=spr_textbox)
{
	var needed_width=1
	var needed_height=2
	
	var sorkoz=1
	var kepkoz=2
	var effect_koz=4
	
	var text_mult=0.14
	
	draw_set_font(fnt_nametag)
	draw_set_halign(textalign_center)
	draw_set_valign(textalign_top )
	draw_set_colour(#101119)
	for (var i=0;i<array_length(stringbox);i++)
	{
		var cwidth_needed=string_width(stringbox[i])*text_mult+10
		var cheight_needed=string_height(stringbox[i])*text_mult
		needed_width=max(cwidth_needed,needed_width)
		needed_height+=cheight_needed+sorkoz
	}
	var eff_length=array_length(effect_sprites_active_list(effect_list))
	if eff_length>0
	{
		needed_height+=effect_koz
		needed_height+=ceil(eff_length/max_effects_in_oneline)*(14+kepkoz)*0.8
		needed_width=max(needed_width,(min(eff_length,max_effects_in_oneline)*(14+kepkoz)+2*kepkoz)*0.8)
	}
	return [needed_width,needed_height]
}



function draw_box_data_icon_and_value_gui(string_val,icon_spr,startx,starty,size,spacing_between,txspr=spr_textbox,text_mult=0.14)
{
	
	
	var needed_width=sprite_get_bbox_right(icon_spr)-sprite_get_bbox_left(icon_spr)+ string_length(string_val)*size*2+5*spacing_between
	var needed_height=max(string_height(string_val)*text_mult,sprite_get_bbox_bottom(icon_spr)-sprite_get_bbox_top(icon_spr))+3*spacing_between
	var mouse_in=false

	if point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),startx,starty,startx+needed_width*size,starty+needed_height*size)
	{
		mouse_in=true
		txspr=spr_textbox_selected_true
	}
	draw_set_font(fnt_nametag)
	draw_set_halign(textalign_center)
	draw_set_valign(textalign_middle	 )
	draw_set_colour(#101119)
	var midx=draw_box_pxs(startx-spacing_between*size,starty-spacing_between*size*0.5,needed_width,needed_height,size,txspr)
	text_mult*=size
	/*text*/
	var curr_text=string_val
	var xx=startx+spacing_between*size+(sprite_get_bbox_right(icon_spr)-sprite_get_bbox_left(icon_spr))*size
	var yy=starty+spacing_between*size+size*2
	draw_sprite_ext(icon_spr, floor(current_time/(1000/sprite_get_speed(icon_spr))) ,xx,yy,size,size,0,c_white,1)
	xx+=spacing_between*size+(needed_width*size-(spacing_between*size+(sprite_get_bbox_right(icon_spr)-sprite_get_bbox_left(icon_spr))*size))*0.5
	yy=starty-spacing_between*0.5*text_mult
		var texttype=0
		if string_starts_with(curr_text,"§b")
		{
			texttype=1
		}
		else if string_starts_with(curr_text,"§i")
		{
			texttype=2
		}
		if string_starts_with(curr_text,"§")
		{
			curr_text=string_copy(curr_text,3,string_length(curr_text)-2)
		}
		draw_text_ext_transformed(xx,starty+needed_height/2,curr_text,1*size,needed_width*size*100,size*text_mult,size*text_mult,0)
		if texttype==1
		{
			draw_text_ext_transformed(xx+0.2*size,starty+needed_height/2,curr_text,1*size,needed_width*size*100,size*text_mult,size*text_mult,0)
			draw_text_ext_transformed(xx-0.2*size,starty+needed_height/2,curr_text,1*size,needed_width*size*100,size*text_mult,size*text_mult,0)
		}
	draw_set_halign(textalign_left)
	draw_set_valign(textalign_top )
	return mouse_in
}

function draw_box_datas(stringbox,effect_list,startx,starty,size,max_effects_in_oneline=3,spr=spr_textbox)
{
	var needed_width=1
	var needed_height=2
	
	var sorkoz=1
	var kepkoz=2
	var effect_koz=4
	
	var text_mult=0.14
	var eff_length=array_length(effect_sprites_active_list(effect_list))

	draw_set_font(fnt_nametag)
	draw_set_halign(textalign_center)
	draw_set_valign(textalign_top )
	draw_set_colour(#101119)
	/*
	for (var i=0;i<array_length(stringbox);i++)
	{
		var cwidth_needed=string_width(stringbox[i])*text_mult+10
		var cheight_needed=string_height(stringbox[i])*text_mult
		needed_width=max(cwidth_needed,needed_width)
		needed_height+=cheight_needed+sorkoz
	}
	
	if eff_length>0
	{
		needed_height+=effect_koz
		needed_height+=ceil(eff_length/max_effects_in_oneline)*(14+kepkoz)*0.8
		needed_width=max(needed_width,(min(eff_length,max_effects_in_oneline)*(14+kepkoz)+2*kepkoz)*0.8)
	}*/
	
	var spaces=draw_box_data_get_width_and_height(stringbox,effect_list,startx,starty,size,max_effects_in_oneline,spr)
	needed_width=spaces[0]
	needed_height=spaces[1]
	
	var midx=draw_box_pxs(startx,starty,needed_width,needed_height,size,spr)
	
	
	//draw text
	var yy=starty+size*sorkoz*3
	for (var i=0;i<array_length(stringbox);i++)
	{
		var curr_text=stringbox[i]
		var texttype=0
		if string_starts_with(curr_text,"§b")
		{
			texttype=1
		}
		else if string_starts_with(curr_text,"§i")
		{
			texttype=2
		}
		if string_starts_with(curr_text,"§")
		{
			curr_text=string_copy(curr_text,3,string_length(curr_text)-2)
		}
		draw_text_ext_transformed(midx,yy,curr_text,sorkoz*size,needed_width*size*100,size*text_mult,size*text_mult,0)
		if texttype==1
		{
			draw_text_ext_transformed(midx+0.2*size,yy,curr_text,sorkoz*size,needed_width*size*100,size*text_mult,size*text_mult,0)
			draw_text_ext_transformed(midx-0.2*size,yy,curr_text,sorkoz*size,needed_width*size*100,size*text_mult,size*text_mult,0)
		}
		yy+=string_height(stringbox[i])*size*text_mult+sorkoz*size
	}
	if eff_length>0
	{
		draw_sprite_ext(spr_textbox_effect_line,0,midx,yy+0.5*size*effect_koz,size,size,0,c_white,1)
		yy+=effect_koz*size
		effect_draw_icons_from_middle(effect_list,midx,yy,kepkoz,size*0.8,max_effects_in_oneline)
	}
	

	draw_set_halign(textalign_left)
	draw_set_valign(textalign_top )
}













/**
 * Draws a box.
 * Returns the middle x coordinate
 * @param {real} _x The x (game) position for the top left corner.
 * @param {real} _y The y (game) position for the top left corner.
 * @param {real} w The pixel length of needed space width
 * @param {real} h The pixel length of needed space height
 * @param {real} size The size multiplier for the sprite.
 * @param {Asset.GMSprite} spr The sprite to draw.
 */ 
function draw_box_pxs(startx,starty,width_px,height_px,size,spr=spr_textbox)
{
	var _spr_width =ceil( sprite_get_width(spr)/3)
	var w =ceil(width_px/_spr_width)
	var h =ceil(height_px/_spr_width)
	draw_box(startx, starty, w, h, size, spr)
	return startx+(w/2)*_spr_width*size
}

/**
 * Draws a box.
 * @param {real} _x The x (game) position for the top left corner.
 * @param {real} _y The y (game) position for the top left corner.
 * @param {real} w The number of horizontal boxes (width). Must be a positive integer.
 * @param {real} h The number of vertical boxes (height). Must be a positive integer.
 * @param {real} size The size multiplier for the sprite.
 * @param {Asset.GMSprite} spr The sprite to draw.
 */
function draw_box(_x, _y, w, h, size, spr) {
	var _spr_width = sprite_get_width(spr)
	var _spr_height = sprite_get_height(spr)
	
	if ( _spr_height != _spr_width) throw ("Sprite width != Sprite hegiht.")
	if ( _spr_width % 3 != 0 ) throw ("Sprite width and height not divisible by 3.")
	
	var _spr_box_size = _spr_width / 3
	_spr_box_size *= size
	
	for (var i=0; i<w; ++i)
	for (var j=0; j<h; ++j) {
			if (i==0 && j==0) // Top left
				draw_sprite_ext(spr, 2, _x, _y, size, size, 0, c_white, 1)
			else 
			if (i==w-1 && j==0) // Top right
				draw_sprite_ext(spr, 4,
				_x + (w - 1 - 2) * _spr_box_size, 
				_y, 
				size, size, 0, c_white, 1)
			
			
			else
			if (i==w-1 && j==h-1) // Bottom right
				draw_sprite_ext(spr, 9,
					_x + (w - 1 - 2) * _spr_box_size,
					_y + (h - 1 - 2) * _spr_box_size,
					size, size, 0, c_white, 1)
			
			else
			if (i==0 && j==h-1) // Bottom left
				draw_sprite_ext(spr, 7,
					_x,
					_y + (h - 1 - 2) * _spr_box_size,
					size, size, 0, c_white, 1)
			
			else
			if (j==0) // Top middle
				draw_sprite_ext(spr, 3,
					_x + (i - 1) * _spr_box_size,
					_y,
					size, size, 0, c_white, 1)
			else
			if (i==w-1) // Right middle
				draw_sprite_ext(spr, 6,
					_x + (w - 2 - 1) * _spr_box_size,
					_y + (j - 1) * _spr_box_size,
					size, size, 0, c_white, 1)
			
			else
			if (j==h-1) // Down middle
				draw_sprite_ext(spr, 8,
					_x + (i - 1) * _spr_box_size,
					_y + (h - 2 - 1) * _spr_box_size,
					size, size, 0, c_white, 1)
			
			else
			if (i==0) // Left middle
				draw_sprite_ext(spr, 5,
					_x,
					_y + (j - 1) * _spr_box_size,
					size, size, 0, c_white, 1)
			
			else
				draw_sprite_ext(spr, 1, // Middle middle
					_x + (i - 1) * _spr_box_size,
					_y + (j - 1) * _spr_box_size,
					size, size, 0, c_white, 1)
	}
}