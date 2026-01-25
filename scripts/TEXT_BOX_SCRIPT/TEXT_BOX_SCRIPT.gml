function add_text_box_gui(data=[txtg()]){
	var text_box_id = instance_create_layer(0, 0, layer, obj_text_box_gui)
	
	text_box_id.data = data
	
	return text_box_id
}

function add_text_box(_id, data=[txt()], offset_x=0, offset_y=-30) {
	var text_box_id = instance_create_depth(0, 0, _id.depth, obj_text_box)
	
	text_box_id.follow_id = _id
	text_box_id.data = data
	text_box_id.offset_x = offset_x
	text_box_id.offset_y = offset_y
	
	return text_box_id
}

function do_nothing() {}

function txt(text="Emptiness..", speaker="Void", lifetime=3000, action=do_nothing) {
	return {
		text: text,
		speaker: speaker,
		lifetime: lifetime,
		action: action
	};
}

function txtg(text="Emptiness..", speaker="Void", action=do_nothing) {
	return {
		text: text,
		speaker: speaker,
		action: action
	};
}