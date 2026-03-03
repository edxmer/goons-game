function effect_sprites_active_list(effect_name_list)
{
	var list=[]
	for (var i=0;i<array_length(effect_name_list);i++)
	{
		var sprite=effect_get_sprite(effect_name_list[i])
		if sprite!=spr_empty
		{
			if !array_contains(list,sprite)
			{
				array_push(list,sprite)
			}
		}
	}
	return list
}


/**
 * Draws all icons in a list of effects
 * @param {array} effect_name_list String list of effect names
 * @param {any*} startx top left x
 * @param {any*} starty top left y
 * @param {real} spacing_px The plus px outside of sprite width
 * @param {real} size The size multiplier of everything
 * @param {real} [max_in_one_line]=3 The max amount of effect that should be in one line
 */
function effect_draw_icons_from_middle(effect_name_list,middlex,starty,spacing_px,size,max_in_one_line=3)
{
	var amount=min(array_length( effect_sprites_active_list( effect_name_list)),max_in_one_line)
	var startx=middlex-(14+spacing_px*1.5)*size*0.5-(14+spacing_px)*size*0.5*(amount-1)
	effect_draw_icons(effect_name_list,startx+spacing_px*size*0.75,starty,spacing_px,size,max_in_one_line)
}
 
 
function effect_draw_icons(effect_name_list,startx,starty,spacing_px,size,max_in_one_line=3)
{
	var sprites=effect_sprites_active_list(effect_name_list)
	var xx=startx
	var yy=starty
	var sprs_in_line=0
	var spr_width=14
	for (var i=0;i<array_length(sprites);i++)
	{
		draw_sprite_ext(sprites[i],0,xx,yy,size,size,0,c_white,1)
		sprs_in_line++
		if sprs_in_line>=max_in_one_line
		{
			sprs_in_line=0
			xx=startx
			yy+=size*(spr_width+spacing_px)
		}
		else
		{
			xx+=size*(spr_width+spacing_px)
		}
	}
	

}



/**
 * Gives back the displayable icon for an effect's name
 * @param {any*} effect Effect name
 * @returns {asset} Description
 */
 

function effect_get_sprite(effect)
{
	switch effect
	{
		case "freezing":
		return spr_effect_freeze
		case "robot":
		return spr_effect_robot
		case "tilt_ground":
		return spr_effect_tilt_ground
		case "building":
		return spr_effect_building
		case "plant":
		return spr_effect_plant
		case "place_snow":
		return spr_effect_snow_globe
		case "pick_up_building":
		return spr_effect_pick_up_building
		case "equippable":
		return spr_effect_equippable
		case "craving":
		return spr_effect_craving
		case "consumable":
		return spr_effect_consumable
		case "calorie_objective":
		return spr_effect_calorie_objective
		case "muted":
		return spr_effect_muted
		case "blue":
		return spr_effect_blue
		case "dumb":
		return spr_effect_dumb
		default:
		return spr_empty
	}
}