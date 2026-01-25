speech_timer -= delta_time/100000

if (speech_timer < 0) {
	speech_timer = random_range(random_min, random_max)
	
	var _goon_count = instance_number(obj_goon)
	var _goon_id = instance_find(obj_goon, irandom(_goon_count-1))
	
	if (!_goon_id.speaking) {
		_goon_id.speaking = true
		var turn_speaking_off = method(_goon_id, function() {
		    speaking = false;
		});
		
		switch (irandom(2)) {
			case (0):
			add_text_box(_goon_id, [
			txt("I sometimes think", "goon"),
			txt("Then I forgor", "?"),
			txt("But then I goon", "goon", 5000, turn_speaking_off)
			])
			break;
			
			case (1):
			add_text_box(_goon_id, [
			txt("Watashi wa", "goon-chan"),
			txt("goon-chan desu", "goon-chan", 5000, turn_speaking_off)
			])
			break;
			
			case (2):
			add_text_box(_goon_id, [
			txt("I think,", "Desgooncartes"),
			txt("Therefore I goon.", "Desgooncartes", 5000, turn_speaking_off)
			])
			break;
		}
		
	}
}