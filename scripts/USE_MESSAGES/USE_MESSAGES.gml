function draw_item_outlined(item_id,_x,_y){
	draw_sprite_ext(spr_outline,0,_x,_y,3,3,0,c_white,1)
	draw_item(_x,_y,item_id,3)
}

function draw_craft_arrow(item_id,_x,_y){
	draw_sprite_ext(spr_outline,0,_x,_y,3,3,0,c_white,1)
	draw_item(_x,_y,item_id,3)
}