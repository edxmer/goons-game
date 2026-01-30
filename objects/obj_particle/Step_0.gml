if !assigned{
assign()
}

x+=x_velocity
y+=y_velocity
if z<0{
z_velocity+=gravity_val
z+=z_velocity

}
else{
z=0
y_velocity*=0.4
x_velocity*=0.4
}

disappear-=delta_time/1000000
if disappear<=0
{
	instance_destroy()
}
else if disappear<=1
{
	alpha-=0.05
}