function special_objectives_init()
{
	global.special_objectives=
	{
		level2:["sock","sock"]
	
	
	}

}


function transform_objective_list()
{

}

function get_special_objective(current_level){
	var index="level"+string(current_level)
	if variable_instance_exists(global.special_objectives,index)
	{
		return variable_instance_get(global.special_objectives,index)
	}
	return false
}

function generate_special_objective(objective_list)
{
	var outputlist=[]
	for (var i=0;i<array_length(objective_list);i++)
	{
		var objt= objective_list[i]
		if objt=="craft"
		{
			var item=pick_one_item_random(workstation_get_craftable_items())
			array_push(outputlist,item)
		}
		else if objt=="summon"
		{
			var item=pick_one_item_random(workstation_get_summoned_items())
			array_push(outputlist,item)
		}
		else if objt=="any"
		{
			var item=pick_one_item_random(workstation_get_all_possible_items())
			array_push(outputlist,item)
		}
		else
		{
			array_push(outputlist,objt)
		}
	
	}
	return outputlist



}