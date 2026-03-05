function calorie_objectives_done_check()
{
	if global.calories_reward_timer>0
	{
		global.calories_reward_timer=max(0,global.calories_reward_timer-delta_time/1000000)
	}
	if global.calories_reward_timer==0 &&!global.special_mode && global.current_calories>=global.needed_calories && array_length(calorie_objectives_needed_list())==0
	{
		calorie_objectives_get_reward()
	}
}

function calorie_objectives_get_reward()
{
	
	with (obj_item)
	{
		if item_id=="reward"
		{
			return false
		}
	}
	coins_get_primordeal_goon(irandom_range(3,4)+floor(global.reward_level/5))
	global.calories_reward_timer=1
	create_item(0,0,"reward")
	return true
}


function calorie_objectives_set_empty()
{
	calorie_objectives_reset()
	calorie_cravings_reset()
	global.current_calories-=global.needed_calories
	global.current_calories=max(0,global.current_calories)

}
function calorie_cravings_generate_new(chosen="empty",calories=-1)
{
	if chosen=="empty"{
		var allitems=get_all_possible_items()
		chosen=allitems[irandom(array_length(allitems)-1)]
	}
	if calories==-1
	{
		calories=ceil(item_get_calories(chosen)*random_range(0.8,max(3,min(9,sqrt(global.reward_level)))))
	}
	calorie_add_new_craving(chosen,calories)
}

function calorie_objective_one_generate_new(objective_amount,chosen="empty",calories=-1)
{
	if chosen=="empty"{
		var allitems=workstation_get_all_possible_items()
		chosen=allitems[irandom(array_length(allitems)-1)]
	}
	if calories=-1{
		calories=ceil(max(item_get_calories(chosen),global.needed_calories*random_range(0.4,0.75)/objective_amount))
	}
	calorie_add_new_objective(chosen,calories)
}
function calorie_objectives_generate_new()
{
	global.needed_calories=20+10*global.reward_level+irandom_range(-10,12)
	var allitems=get_all_possible_items()
	var chosen=allitems[irandom(array_length(allitems)-1)]
	var cravings=irandom_range(2,min(2,floor(sqrt(global.reward_level))))+random_range(-2,3)
	repeat cravings{
		calorie_cravings_generate_new()
	}
	var objectives=max(0,irandom_range(1,min(2,floor(global.reward_level/10)+irandom_range(-2,2)+floor(global.reward_level/50))))
	repeat objectives
	{
		calorie_objective_one_generate_new(objectives)
	}
}

function calorie_objectives_new()
{
	calorie_objectives_set_empty()
	calorie_objectives_generate_new()

}