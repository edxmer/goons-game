real_x=x
real_y=y

size=3

priority=0

on_mouse=false
active=false

sign_sizes=0

signs=[]

text_mult=0.5

sign_selected=-1

new_sign=function(name,func)
{
	return {name:name,func:func}

}
close_up=function()
{
	if active
	{
		move_below(-sign_sizes)
	}
	active=false
}



open_up=function()
{
	if !active
	{
		move_below(sign_sizes)

	}
	active=true

}

move_below=function(amount)
{
	with(obj_new_gui_parent)
		{
			
			if priority>other.priority
			{
				real_y+=amount
			}
		}


}

calculate_sign_size=function()
{
	sign_sizes=array_length(signs)*size*10

}

update_opened=function()
{
	var last=sign_sizes
	calculate_sign_size()
	var diff = sign_sizes - last
	if abs(diff )<1
	{
		move_below(diff)
	}

}