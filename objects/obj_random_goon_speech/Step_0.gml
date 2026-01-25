var _speak_chance = speak_chance * delta_time



if (_speak_chance <= random(1) || true) {
	var _goon_count = instance_number(obj_goon)
	_goon_id = instance_find(obj_goon, irandom(_goon_count-1))
	
	if (!_goon_id.speaking) {
		_goon_id.speaking = true
		var turn_speaking_off = function() {
			_goon_id.speaking = false
		}
		add_text_box(_goon_id, [
		txt("I sometimes think", "goon"),
		txt("Then I forgor", "?"),
		txt("But then I goon", "goon", 5000, turn_speaking_off)
		])
	}
}