global.reward_mode=true
global.reward_level+=1
lootpool=[["workstation","sign"],["workstation","tree"],["item","goo"],["item","goon_show"],["workstation","trashcan"],["workstation","woodcutter"]]


if global.reward_level>4
{
	array_push(lootpool,["workstation","nightstand"])
	array_push(lootpool,["item","goo"])
}
if global.reward_level>7
{
	array_push(lootpool,["workstation","cigs"])
	array_push(lootpool,["item","goon_blue"])
	array_push(lootpool,["item","goon_blue"])
	array_push(lootpool,["item","goo"])
	array_push(lootpool,["item","goo"])
}
if global.reward_level==4
{
	lootpool=[["workstation","nightstand"]]
}

if global.reward_level==7
{
	lootpool=[["workstation","cigs"]]
}

for(var i=0;i<3;i++)
{
	var reward=instance_create_depth(x,y,-room_height*2,obj_reward_one)
	reward.reward_no=i
	var selected_reward=lootpool[irandom_range(0,array_length(lootpool)-1)]
	reward.reward_id=selected_reward[1]
	reward.type=selected_reward[0]
}