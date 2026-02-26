function item_get_calories(item_id){
	var base=assign_item(item_id).calories

	for (var i=0;i<array_length(global.current_calorie_objectives);i++)
	{
		var objective=global.current_calorie_objectives[i]
		if objective.item_id==item_id
		{
			return max( objective.calories,base)
		}
	}
	for (var i=0;i<array_length(global.current_calorie_cravings);i++)
	{
		var crave_struct=global.current_calorie_cravings[i]
		if crave_struct.item_id==item_id
		{
			base+=crave_struct.bonus_calories
		}
	}
	return base
}


/**
 * Eats an item_id
 * Gives back strings based on what happened
 * If it has 0 calories, gives back "not_eaten"
 * If it was not a calorie objectives gives back "eaten"
 * If it was a calorie objective gives back "was_objective"
 * @param {string} item_id Description
 */
function calorie_item_eat(item_id)
{
	var calories=item_get_calories(item_id)
	if calories>0
	{
		global.current_calories+=calories
		if calorie_objective_done(item_id)
		{
			return "was_objective"
		}
		if is_item_craving(item_id)
		{
			return "was_craving"
		}
		return "eaten"
	}
	
	return "not_eaten"
}




function calorie_add_new_objective(item_id,calories)
{
	array_push(global.current_calorie_objectives,
	s_objective_normal(item_id, calories, false))
}

/**
 * Adds a new craving
 * If it already existed, it adds bonus calories_amount
 * to the current .bonus_calories amount
 * @param {any} item_id The craving item
 * @param {real} bonus_calories The bonus calories modifier
 * @returns {bool} Description
 */
function calorie_add_new_craving(item_id,bonus_calories)
{
	if !is_item_craving(item_id)
	{
		array_push(global.current_calorie_cravings,
		s_objective_craving(item_id, bonus_calories))
		return true
	}
	else
	{
		for (var i=0;i<array_length(global.current_calorie_cravings);i++)
		{
			if !global.current_calorie_cravings[i].item_id==item_id
			{
				global.current_calorie_cravings[i].bonus_calories+=bonus_calories
			}
		}
		return false
	}
}

function is_item_craving(item_id)
{
	return array_contains(calorie_cravings_list(),item_id)
}

function item_get_craving_bonus_calories(item_id)
{
	if is_item_craving(item_id)
	{
		for (var i=0;i<array_length(global.current_calorie_cravings);i++)
		{
			if !global.current_calorie_cravings[i].item_id==item_id
			{
				return global.current_calorie_cravings[i].bonus_calories
			}
		}
	}
	return 0
}

 /**
 * Returns if a given item id is a still not done calorie objective
 * @returns {array}
 */
 function is_item_needed_calorie_objective(item_id)
 {
	return array_contains(calorie_objectives_needed_list(),item_id)
 }
 /**
 * Gives back all current calorie objectives that are not yet done
 * 
 * Returns an array of the needed item_ids
 * @returns {array}
 */
function calorie_objectives_needed_list()
{
	var undone_calorie_objectives=[]
	for (var i=0;i<array_length(global.current_calorie_objectives);i++)
	{
		if !global.current_calorie_objectives[i].done
		{
			array_push(undone_calorie_objectives,global.current_calorie_objectives[i])
		}
	}
	return undone_calorie_objectives
}

function calorie_cravings_list()
{
	var calorie_cravings=[]
	for (var i=0;i<array_length(global.current_calorie_cravings);i++)
	{
		array_push(calorie_cravings,global.current_calorie_cravings[i])
	}
	return calorie_cravings
}
/**
 * Sets a calorie objective to done, if it found something still needed, returns true
 *
 * If it didn't, or it was already done, returns false 
 * Returns an array of the needed item_ids
 * @returns {array}
 */
function calorie_objective_done(item_id)
{
	var i=0;
	while (array_length(global.current_calorie_objectives)>i && global.current_calorie_objectives[i].item_id!=item_id && !(global.current_calorie_objectives[i].done))
	{ i++}
	if array_length(global.current_calorie_objectives)>i
	{
		global.current_calorie_objectives[i].done=true
		return true
	}
	return false


}
/**
 * Sets the Current Calorie Objectives empty.
 */
function calorie_objectives_reset()
{
	global.current_calorie_objectives=[]

}
/**
 * Sets the Current Calorie Cravings empty.
 */
function calorie_cravings_reset()
{
	global.current_calorie_cravings=[]

}