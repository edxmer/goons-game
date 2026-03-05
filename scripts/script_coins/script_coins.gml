function coins_get_one(_x,_y){
	particle_fly(_x,_y)
	global.coins++
}

function coins_get_amount(_x,_y,amount)
{
	repeat amount
	{
		coins_get_one(_x,_y)
	}

}

function coins_get_primordeal_goon(amount)
{
	var xx=global.room_height/2
	var yy=room_width/2
	with(obj_work_station)
	{
		if primordeal_goo
		{
			xx=x 
			yy=y 
		}
	
	}
	coins_get_amount(xx,yy,amount)


}