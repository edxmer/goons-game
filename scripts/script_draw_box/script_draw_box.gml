

function item_selected_draw_box_datas(item_id,size)
{
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
	return ef_tags
}


function item_draw_box_datas(item_id,startx,starty,size)
{
	var calories_text=string(item_get_calories(item_id))+" kcal"
	var tags=item_get_effect_tags(item_id)
	draw_box_datas([calories_text],tags,startx,starty,size,3,spr_textbox)
}

function draw_box_datas(stringbox,effect_list,startx,starty,size,max_effects_in_oneline=3,spr=spr_textbox)
{
	var needed_width=1
	var needed_height=2
	
	var sorkoz=1
	var kepkoz=2
	
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
		needed_height+=cheight_needed+sorkoz*text_mult
	}
	var eff_length=array_length(effect_sprites_active_list(effect_list))
	if eff_length>0
	{
		needed_height+=5
		needed_height+=ceil(eff_length/max_effects_in_oneline)*(14+kepkoz)*0.8
		needed_width=max(needed_width,(min(eff_length,max_effects_in_oneline)*(14+kepkoz)+2*kepkoz)*0.8)
	}
	var midx=draw_box_pxs(startx,starty,needed_width,needed_height,size,spr)
	
	
	//draw text
	var yy=starty+size*sorkoz*3
	for (var i=0;i<array_length(stringbox);i++)
	{
		
		draw_text_ext_transformed(midx,yy,stringbox[i],sorkoz*size,needed_width*size*100,size*text_mult,size*text_mult,0)
		yy+=string_height(stringbox[i])*size*text_mult
	}
	if eff_length>0
	{
		yy+=5*size
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