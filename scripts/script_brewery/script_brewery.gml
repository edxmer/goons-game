
function sprite_get_colors(sprite)
{
    var _surf = surface_create(sprite_get_width(sprite), sprite_get_height(sprite));
    surface_set_target(_surf);
    draw_clear_alpha(c_black, 0);
    draw_sprite(sprite, 0, 0, 0);
    surface_reset_target();
    
    var _colors = ds_map_create();
    for (var _y = 0; _y < sprite_get_height(sprite); _y++) {
        for (var _x = 0; _x < sprite_get_width(sprite); _x++) {
            var _col_ext = surface_getpixel_ext(_surf, _x, _y);

                var _col = surface_getpixel(_surf, _x, _y);
                _colors[? _col] = true;

        }
    }
    
    var carray = ds_map_keys_to_array(_colors);
    ds_map_destroy(_colors);
    surface_free(_surf);
    return carray;
}
function know_new_recipe(recipe_name)
{
	if !array_contains(global.npc_brewery_known_recipes, recipe_name)
	{
		global.npc_brewery_new_recipe=true
		array_push(global.npc_brewery_known_recipes, recipe_name)
	}

}


function sprite_get_average_color(sprite)
{
    var _surf = surface_create(sprite_get_width(sprite), sprite_get_height(sprite));
    surface_set_target(_surf);
    draw_clear_alpha(c_black, 0);
    draw_sprite(sprite, 0, 0, 0);
    surface_reset_target();
    
    var _col = c_black;
    for (var _y = 0; _y < sprite_get_height(sprite); _y++) {
        for (var _x = 0; _x < sprite_get_width(sprite); _x++) {
            var _ext = surface_getpixel_ext(_surf, _x, _y);
            if ((_ext >> 24) & 255 > 0) {
                _col = _ext & $FFFFFF;
                break;
            }
        }
        if (_col != c_black) break;
    }
    
    surface_free(_surf);
    return _col;
}
function colors_blend(c1,c2)
{
	var red=(colour_get_red(c1)+colour_get_red(c2))/2
	var blue=(colour_get_blue(c1)+colour_get_blue(c2))/2
	var green=(colour_get_green(c1)+colour_get_green(c2))/2
	return make_colour_rgb(red,green,blue)


}



function sprite_get_lightest_color(sprite)
{
	var c_base= #00BFF3
	var colors=sprite_get_colors(sprite)
	for (var i=0;i<array_length(colors);i++)
	{
		c_base=max(c_base,colors[i])
	}
	return c_base

}
function potion_get_recipe_empty()
{
	return {name:"recipe_1",brew_into:"potion_empty",color: #FFBD3A , recipe:["corn_cob","corn_cob"],value:3}

}

function potion_set_recipe(name,potion,color,recipe,value)
{
	var rpotion=potion_get_recipe_empty()
	rpotion.name=name
	rpotion.brew_into=potion
	rpotion.color=color
	rpotion.recipe=recipe
	rpotion.value=value
	return rpotion

}

function potion_name_get_name(p_name)
{
	var ret_str=""
	var parts=string_split(p_name,"_")
	for(var i=0;i<array_length(parts);i++)
	{
		
		var part=parts[i]
		if part == "" continue
		if !array_contains(["of","and"],part)
		{
			part=string_upper(string_copy(part,1,1))+string_copy(part,2,string_length(part)-1)
		}
		ret_str+=part
		if i!=array_length(parts)-1
		{
			ret_str+=" "
		}
	}
	return ret_str

}

function potion_get_recipe_name(name,more=false)
{
	var r_name=string_copy(name,1,string_length(name))
	if item_get_sprite(r_name)!=spr_empty
	{
		r_name =item_get_name(r_name)
		if more
		{
			r_name+="(s)"
		}
		return r_name
	}
	else
	{
		r_name=string_replace(r_name,"_"," ")
		r_name=string_replace(r_name,"*","Any")
		r_name=string_upper(string_copy(part,1,1))+string_copy(part,2,string_length(part)-1)
		if more
		{
			r_name+="(s)"
		}
		return r_name
	}
}

function potion_get_recipe_text(p_needed_items)
{
	var itemtext=[]
	var dist_items=array_to_distinct(p_needed_items)
	for (var i=0;i<(array_length(dist_items));i++)
	{
		var itemc=dist_items[i]
		var count=array_count(p_needed_items,itemc)
		var r_name=potion_get_recipe_name(itemc,count>1)

		array_push(itemtext,string(count)+" "+r_name)
		
	}
	return itemtext
}

function potion_get_recipes(type="all")
{
	
	var rlist=[]
	var curr="corn_syrup"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"corn_syrup",#FFBD3A,["corn_cob","corn_cob"],4)
		array_push(rlist,potion)
	}
	curr="muting_brew"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"potion_of_mute",#C96EEA,["sock","rock"],2)
		array_push(rlist,potion)
	}
	curr="liquid_doom"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"potion_of_doom",#42705C,["sock","wloob_confused"],2)
		array_push(rlist,potion)
	}
	curr="hot_dog"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"hot_dog",#E59770,["cat_tail","wloob_confused"],4)
		array_push(rlist,potion)
	}
	curr="casserole"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"casserole",#EA9E56,["vegetable","vegetable"],3)
		array_push(rlist,potion)
	}
	curr="pina_colada"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"pina_colada",#F1FF7A,["pineapple"],4)
		array_push(rlist,potion)
	}
	curr="gummy_goon"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"gummy_goon",#FF569F,["fruit","purple_mushroom"],4)
		array_push(rlist,potion)
	}
	curr="nature_juice"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"nature_juice",#53ED62,["plant"],1)
		array_push(rlist,potion)
	}
	curr="corn_seeds"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"corn_seeds",#EDE138,["corn_cob","hoe"],3)
		array_push(rlist,potion)
	}
	curr="elderberry_seeds"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"elderberry_seeds",#E2641F,["elderberry","hoe"],3)
		array_push(rlist,potion)
	}
	curr="purple_spores"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"purple_mushroom_spores",#A55BFF,["purple_mushroom","hoe"],3)
		array_push(rlist,potion)
	}
	curr="pineapple_seeds"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"pineapple_seeds",#FFD400,["pineapple","hoe"],5)
		array_push(rlist,potion)
	}
	curr="cat_tail_seeds"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"cat_tail_seeds",#20C961,["cat_tail","hoe"],3)
		array_push(rlist,potion)
	}
	curr="homonculus"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"homonculus",#EDE138,["goo"],7)
		array_push(rlist,potion)
	}
	curr="turnip_seeds"
	if type=="all" || type==curr
	{
		var potion=potion_set_recipe(curr,"turnip_seeds",#EF75DD,["turnip","hoe"],3)
		array_push(rlist,potion)
	}
	
	
	
	
	
	
	
	return rlist

}


function current_ingredients_push(ingredients,item_id)
{
	var tags=item_get_tags(item_id)
	for (var i=0;i<array_length(tags);i++)
	{
		array_push(ingredients,tags[i])
	
	}

	return ingredients
}


function ingredients_evaluate(ingredients,current_value,current_potion,current_color,recipes=[])
{
	var rec_real=recipes
	var name="empty"
	if array_length(recipes)==0
	{
		rec_real=potion_get_recipes("all")
	}
	var real_value=current_value
	var brew_into=current_potion
	var color=current_color
	for (var i=0;i<array_length(rec_real);i++)
	{
		
		var recipe=rec_real[i]
		if recipe.value>current_value && is_subset(ingredients,recipe.recipe)
		{
			name=recipe.name
			current_value=recipe.value
			brew_into=recipe.brew_into
			real_value=recipe.value
			color=recipe.color
		}
		
		
	}
	
	return potion_set_recipe(name,brew_into,color,[],real_value)
}