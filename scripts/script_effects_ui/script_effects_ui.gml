function effect_sprites_active_list(effect_name_list,names_instead=false)
{
	var list=[]
	for (var i=0;i<array_length(effect_name_list);i++)
	{
		var sprite=effect_get_sprite(effect_name_list[i],names_instead)
		if sprite!=spr_empty && sprite!="Empty"
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
 
 
function effect_draw_icons(effect_name_list,startx,starty,spacing_px,size,max_in_one_line=3,shownames=true)
{
	var sprites=effect_sprites_active_list(effect_name_list)
	var xx=startx
	var yy=starty
	var sprs_in_line=0
	var spr_width=14
	var shownameind=-1
	for (var i=0;i<array_length(sprites);i++)
	{
		var size_c=size
		var minmin=0
		if shownames && point_in_rectangle(mouse_x,mouse_y,xx,yy,xx+12*size,yy+12*size)
		{
			shownameind=i
			size_c*=1.05
			minmin=(size_c-size)*6
			
		}
		draw_sprite_ext(sprites[i],0,xx-minmin,yy-minmin,size_c,size_c,0,c_white,1)
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
	if shownames && shownameind!=-1
	{
		draw_nametag(effect_sprites_active_list(effect_name_list,true)[shownameind])
	}

}



/**
 * Gives back the displayable icon for an effect's name
 * @param {any*} effect Effect name
 * @returns {asset} Description
 */
 

function effect_get_sprite(effect,name=false)
{
	switch effect
	{
		case "freezing":
		if name {return "Freezing"}
		return spr_effect_freeze
		case "robot":
		if name {return "Repeating"}
		return spr_effect_robot
		case "tilt_ground":
		if name {return "Tilt Ground"}
		return spr_effect_tilt_ground
		case "building":
		if name {return "Building"}
		return spr_effect_building
		case "plant":
		if name {return "Planting"}
		return spr_effect_plant
		case "place_snow":
		if name {return "Snowy Feet"}
		return spr_effect_snow_globe
		case "pick_up_building":
		if name {return "Destruct"}
		return spr_effect_pick_up_building
		case "equippable":
		if name {return "Equippable"}
		return spr_effect_equippable
		case "craving":
		if name {return "*Craving*"}
		return spr_effect_craving
		case "consumable":
		if name {return "Consumable"}
		return spr_effect_consumable
		case "calorie_objective":
		if name {return "*Objective*"}
		return spr_effect_calorie_objective
		case "muted":
		if name {return "Muted"}
		return spr_effect_muted
		case "blue":
		if name {return "Blue Goon"}
		return spr_effect_blue
		case "dumb":
		if name {return "Dumb Goon"}
		return spr_effect_dumb
		case "enemy":
		if name {return "Enemy"}
		return spr_effect_enemy
		case "witch":
		if name {return "Brewery"}
		return spr_effect_witch
		case "health_boost":
		if name {return "Health Boost"}
		return spr_effect_health_boost
		case "permanent_health_boost":
		if name {return "Permanent Health Boost"}
		return spr_effect_health_boost_permanent
		default:
		if name {return "Empty"}
		return spr_empty
	}
}