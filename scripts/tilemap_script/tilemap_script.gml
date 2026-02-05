function set_tilemap_snow(tx,ty){
	if get_tile_index(tx,ty)==9{
		set_tile_index(tx,ty,3)
		update_nearby_tiles(tx,ty)
	}

}
function set_tilemap_ground(tx,ty){
	if is_tile_snowy(tx,ty){
		set_tile_index(tx,ty,9)
		update_nearby_tiles(tx,ty)
	}
}

function get_tile_index(tx,ty)
{
	var tile_id=layer_tilemap_get_id("ground_layer")
	return tilemap_get(tile_id,tx,ty)
}

function set_tile_index(tx,ty,setto)
{
	var tile_id=layer_tilemap_get_id("ground_layer")
	tilemap_set(tile_id,setto,tx,ty)
}

function update_nearby_tiles(tx,ty)
{
	for (var i=ty-1;i<=ty+1;i++)
	{
		
		for (var j=tx-1;j<=tx+1;j++)
		{
			tile_update(j,i)
		}
	}
}

function is_tile_snowy(tx,ty)
{
	if tx<0 || tx >=(room_width>>4)
	{
		return true
	}
	if ty<0 || ty >=(room_height>>4)
	{
		return true
	}
	return array_contains([1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17],get_tile_index(tx,ty))
}

function are_arrays_equal(array1,array2)
{
	if array_length(array1)!=array_length(array2)
	{
		return false
	}
	else{
		for (var i=0;i<array_length(array1);i++)
		{
			if array1[i]!=array2[i]
			{
				return false
			}
		
		}
		return true
		
	}

}

function snowy_get_tilegrid(tx,ty)
{
	var grid=[]
	for (var i=ty-1;i<=ty+1;i++)
	{
		array_push(grid,[])
		for (var j=tx-1;j<=tx+1;j++)
		{
			array_push(grid[i-(ty-1)],is_tile_snowy(j,i))
		}
	}
	
	return grid
}

function tile_update(tx,ty)
{
	var update_more=true
	if tx<0 || tx >=(room_width>>4)
	{
		return
	}
	if ty<0 || ty >=(room_height>>4)
	{
		return
	}
	if is_tile_snowy(tx,ty)
	{
		var shouldbe=	tile_update_snowy_texture(tx,ty,snowy_get_tilegrid(tx,ty))
		if shouldbe!=get_tile_index(tx,ty)
		{
			set_tile_index(tx,ty,shouldbe)
		}
		else
		{
			update_more=false
		}
	}
	else
	{
		update_more=false
	}
	
	if update_more
	{
		update_nearby_tiles(tx,ty)
	}

}


function tile_update_snowy_texture(tx,ty,tilemap_grid)
{
	//[false,false,false],[false,true,false],[false,false,false]
	var shouldbe=17
	if tilemap_grid[1][1]==false
	{
		shouldbe=9
	}
	else if tilemap_grid[0][1]==true
	{
		if tilemap_grid[2][1]==true
		{
			if tilemap_grid[1][0]==true
			{
				if tilemap_grid[1][2]==true
				{
					if are_arrays_equal([true,true,true], tilemap_grid[0]) &&are_arrays_equal([true,true,true], tilemap_grid[2])
					{
						shouldbe=3
					}
					else if are_arrays_equal([true,true,true], tilemap_grid[0])
					{
						if are_arrays_equal([false,true,true], tilemap_grid[2])
						{
							shouldbe=6
						}
						else if are_arrays_equal([true,true,false], tilemap_grid[2])
						{
							shouldbe=4
						}
						else{
							shouldbe=5
						}
					
					}
					else if are_arrays_equal([true,true,true], tilemap_grid[2])
					{
						if are_arrays_equal([false,true,true], tilemap_grid[0])
						{
							shouldbe=14
						}
						else if are_arrays_equal([true,true,false], tilemap_grid[0])
						{
							shouldbe=12
						}
						else{
							shouldbe=13
						}
					
					}
					else
					{
						if are_arrays_equal([true,true,false], tilemap_grid[0]) && are_arrays_equal([false,true,true], tilemap_grid[2])
						{
							shouldbe=7
						}
						else if are_arrays_equal([false,true,true], tilemap_grid[0]) && are_arrays_equal([true,true,false], tilemap_grid[2])
						{
							shouldbe=16
						}
						else if are_arrays_equal([true,true,false], tilemap_grid[0]) && are_arrays_equal([true,true,false], tilemap_grid[2])
						{
							shouldbe=8
						}
						else if are_arrays_equal([false,true,true], tilemap_grid[0]) && are_arrays_equal([false,true,true], tilemap_grid[2])
						{
							shouldbe=10
						}
						else if tilemap_grid[0][0]==true
						{
							shouldbe=2
						}
						else if tilemap_grid[0][2]==true
						{
							shouldbe=1
						}
						else if tilemap_grid[2][2]==true
						{
							shouldbe=15
						}
						else if tilemap_grid[2][0]==true
						{
							shouldbe=11
						}
					
					}

				}


				else if tilemap_grid[2][0]==true &&  tilemap_grid[0][0]==true
				{
					shouldbe=8
				}
				else if tilemap_grid[2][0]==true
				{
					shouldbe=11
				}
				else if tilemap_grid[0][0]==true
				{
					shouldbe=2
				}
			}
			else if tilemap_grid[1][2]==true &&  tilemap_grid[2][2]==true &&  tilemap_grid[0][2]==true
			{
				shouldbe=10
			}
			else if tilemap_grid[1][2]==true && tilemap_grid[2][2]==true && tilemap_grid[0][2]==false
			{
				shouldbe=15
			}
			else if tilemap_grid[1][2]==true && tilemap_grid[2][2]==false && tilemap_grid[0][2]==true
			{
				shouldbe=1
			}
			
		}
		else if tilemap_grid[1][2]==true && tilemap_grid[1][0]==true && tilemap_grid[0][2]==true && tilemap_grid[0][0]==true
		{
			shouldbe=5
		}
		else if tilemap_grid[1][2]==true && tilemap_grid[0][2]==true
		{
			shouldbe=1
		}
		else if tilemap_grid[1][0]==true && tilemap_grid[0][0]==true
		{
			shouldbe=2
		}
		

	}
	else if tilemap_grid[1][2]==true && tilemap_grid[2][1]==true && tilemap_grid[1][0]==true  && tilemap_grid[2][0]==true  && tilemap_grid[2][2]==true
	{
		shouldbe=13
	}
	else if tilemap_grid[1][2]==true && tilemap_grid[2][1]==true && tilemap_grid[2][2]==true
	{
		shouldbe=15
	}
	else if tilemap_grid[1][0]==true && tilemap_grid[2][1]==true && tilemap_grid[2][0]==true
	{
		shouldbe=11
	}
	
	return shouldbe
}