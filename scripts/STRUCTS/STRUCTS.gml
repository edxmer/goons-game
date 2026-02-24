

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
