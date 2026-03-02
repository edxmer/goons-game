

/**
 * @param {String} item_id
 * @param {Real} calories
 * @param {Bool} done
 */
function s_objective_normal(item_id, calories, done) {
	return {
		item_id: item_id,
		calories: calories,
		done: done
	}
}



/**
 * @param {String} item_id
 * @param {Real} bonus_calories
 */
function s_objective_craving(item_id, bonus_calories) {
	return {
		item_id: item_id,
		bonus_calories: bonus_calories
	}
}

/**
 * Function Description
 * @param {any*} calorie_objective_list [[item_id,calories_given_or_precentage,calorie_is_percentage=false],..]
 * @param {any*} calorie_craving_list [[item_id,bonus_calories_or_base_plus_percentages,calorie_is_base_percentage=false],...]
 * @param {any*} needed_calories how many calories are needed
 */
function s_special_objectives(calorie_objective_list,calorie_craving_list,needed_calories)
{
	var ret_struct={needed_calories:needed_calories,calorie_objectives:[],calorie_cravings:[]}
	for (var i=0;i<array_length(calorie_objective_list);i++)
	{
		var curr_obj=calorie_objective_list[i]
		var curr_str={item_id:curr_obj[0],calories:curr_obj[1]}
		if array_length(curr_obj)==3
		{
			if curr_obj[3]
			{
				curr_str.calories=needed_calories*curr_obj[1]
			}
		}
		array_push(ret_struct.calorie_objectives,curr_str)
	}
	for (var i=0;i<array_length(calorie_craving_list);i++)
	{
		var curr_obj=calorie_craving_list[i]
		var curr_str={item_id:curr_obj[0],bonus_calories:curr_obj[1]}
		if array_length(curr_obj)==3
		{
			if curr_obj[3]
			{
				curr_str.bonus_calories=needed_calories*item_get_calories(curr_obj[0])
			}
		}
		array_push(ret_struct.calorie_cravings,curr_str)
	}
	return ret_struct
}