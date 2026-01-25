

speak_chance = 0.05


var _goon_count = instance_number(obj_goon)

for (var i = 0; i < instance_number(obj_goon); ++i)
{
    instance_find(obj_goon,i).speaking = false
}