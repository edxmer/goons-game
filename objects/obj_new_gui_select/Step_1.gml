// Inherit the parent event

if active
{
var gc=0
var ggc=gooning_goons_count()
with (obj_goon)
{
	gc++
}
if ggc==gc
{
	signs=[reset_zoom,unselect_nearest,unselect_all]
}
else if ggc==0
{
	signs=[reset_zoom,select_nearest,select_all]
}
else
{
	signs=[reset_zoom,select_nearest,unselect_nearest,select_all,unselect_all]

}
}
event_inherited();