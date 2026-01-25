if !assigned
{
	assign()
	useful=useful_function()
}

if size<1
{
	size+=0.08
	size=min(1,size)
}

if item_id="goon_show" && size>=0.95
{
	instance_create_depth(x,y,depth,obj_goon)
	instance_destroy()
}