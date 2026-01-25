
random_min = 25
random_max = 50

speech_timer = random_range(random_min, random_max)

var _goon_count = instance_number(obj_goon)

for (var i = 0; i < instance_number(obj_goon); ++i)
{
    instance_find(obj_goon,i).speaking = false
}