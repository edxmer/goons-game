


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