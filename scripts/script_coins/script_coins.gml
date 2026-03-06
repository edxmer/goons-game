function draw_money_box_gui(startx,starty,sprite,size)
{
	var mouse_in=draw_box_data_icon_and_value_gui(string(global.coins)+" ",sprite,startx,starty,size,2,spr_textbox,0.08)
	return mouse_in
}

function draw_money_box_cost_gui(startx,starty,sprite,cost,size,base_sprite=spr_textbox)
{
	var mouse_in=draw_box_data_icon_and_value_gui(string(cost)+" ",sprite,startx,starty,size,1,base_sprite,0.07)
	return mouse_in
}


function coins_get_one(_x,_y){
	particle_fly(_x,_y)
	global.coins++
}

function summon_flies(_x,_y,amount)
{
	repeat amount
	{
		particle_fly(_x,_y)
	}
}

function coins_remove_one(_x,_y,flies=true,size=1){
	if flies{
		particle_fly(_x,_y,size)
	}
	global.coins--
}
function coins_remove_amount(_x,_y,amount,flies=true,size=1)
{
	repeat amount
	{
		coins_remove_one(_x,_y,flies,size)
	}

}

function coins_can_buy(amount)
{
	return global.coins>=amount
}

function coins_buy_if_can(_x,_y,amount,flies=true,size=1)
{
	if coins_can_buy(amount)
	{
		coins_remove_amount(_x,_y,amount,flies,size)
		return true
	}
	return false
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