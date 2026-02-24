

function pos(_x, _y) {
	return {
		x: _x,
		y: _y
	}
}

function generate_path(p1, p2, i) {

	var _hit = collision_line(x1, y1, x2, y2, obj_wall, true, false)

	if (_hit == noone) {
		return
	}
	
}

function gather_collisions(p1,p2)
{
	var idlist=ds_list_create()
	var amount=collision_line_list(p1[0],p1[1],p2[0],p2[1],obj_work_station,false,true,idlist,true)
	var listtrue=[]
	for (var i=0;i<amount;i++)
	{
		var id_to_put=ds_list_find_value(idlist,i)
		if !workstation_tags_contain(id_to_put.station_id,"can_walk_through")
		{
			array_push(listtrue,id_to_put)
		}
	}
	//var listtrue=ds_list_ (idlist)
	ds_list_destroy(idlist)
	return listtrue
}

function gather_colliding_coords(p1,p2)
{
	var cord_list=[]
	var coll_ids=gather_collisions(p1,p2)
	for (var i=0;i<array_length(coll_ids);i++)
	{
		array_push(cord_list,[coll_ids[i].x,coll_ids[i].y,coll_ids[i]])
	}
	return cord_list
}

function closest_point_on_line(px, py, x1, y1, x2, y2)
{
    var dx = x2 - x1;
    var dy = y2 - y1;
    var len2 = dx*dx + dy*dy; // |AB|^2

    if (len2 == 0) return [x1, y1]; // A=B, degenerate line

    // projection factor
    var t = ((px - x1)*dx + (py - y1)*dy) / len2;
    t = clamp(t, 0, 1);

    var cx = x1 + t*dx;
    var cy = y1 + t*dy;

    return [cx, cy];
}


function pathfind_fix_points(p1,p2)
{
	var bad_coords=gather_colliding_coords(p1,p2)
	var startpoint=p1
	
	
	 var good_coords=[p1]
	 for (var i=0;i<array_length(bad_coords);i++)
	 {
		//array_push(good_coords,bad_coords[i])
		array_push(good_coords,bad_coords[i])
	 }
	 array_push(good_coords,p2)
	 var endpoint=good_coords[1]
	for (var i=0;i<array_length(bad_coords);i++)
	{
		endpoint=good_coords[i+2]
		startpoint=good_coords[i]
		var fix_coord=bad_coords[i]
		
		var fix_id=fix_coord[2]
		var online=closest_point_on_line(fix_coord[0],fix_coord[1],p1[0],p1[1],p2[0],p2[1])
		var look=point_direction(fix_coord[0],fix_coord[1],online[0],online[1])
		var maxtries=20
		while maxtries>0 &&((collision_line(startpoint[0],startpoint[1],good_coords[i+1][0],good_coords[i+1][1],fix_id,false,true)!=noone) || (collision_line(endpoint[0],endpoint[1],good_coords[i+1][0],good_coords[i+1][1],fix_id,false,true)!=noone))
		{
			maxtries--
			var _xdiff=lengthdir_x(2,look)
			var _ydiff=lengthdir_y(2,look)
			good_coords[i+1][0]+=_xdiff
			good_coords[i+1][1]+=_ydiff
			
			
			
		}
		
		
		
	}
	var return_coords=[]
	for (var i=1;i<array_length(good_coords)-1;i++)
	{
		array_push(return_coords,[good_coords[i][0],good_coords[i][1]])
	}
	array_push(return_coords,p2)
	return return_coords

}