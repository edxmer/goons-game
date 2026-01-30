

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