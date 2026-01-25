function add_gui_text_box(texts=["Emptiness..", "Inside my head..."], speaker="Void"){
	var text_box_id = instance_create_layer(0, 0, layer, obj_text_box_gui)
	
	text_box_id.texts = texts
	text_box_id.speaker_name = speaker
}

function add_text_box(_x=0, _y=0, texts=["Emptiness..", "Inside my head..."], speaker="Void"){
	var text_box_id = instance_create_layer(0, 0, layer, obj_text_box)
	
	text_box_id.texts = texts
	text_box_id.speaker_name = speaker
	text_box.x = _x
	text_box.y = _y
}