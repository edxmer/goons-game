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




function add_new_calorie_objective(item_id,calories)
{
	s_objective_normal(item_id, calories, false)
}