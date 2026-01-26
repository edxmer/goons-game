global.reward_mode=true
global.reward_level+=1
lootpool=[["item","goo"],["item","goon_show"],["workstation","trashcan"],["workstation","woodcutter"]]


for(var i=0;i<3;i++)
{
	var reward=instance_create_depth(x,y,-room_height*2,obj_reward_one)
	reward.reward_no=i
	var selected_reward=lootpool[irandom_range(0,array_length(lootpool)-1)]
	reward.reward_id=selected_reward[1]
	reward.type=selected_reward[0]
}