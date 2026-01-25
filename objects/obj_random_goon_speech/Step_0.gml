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
		
		switch (irandom(9)) {
			case (0):
			add_text_box(_goon_id, [
			txt("I sometimes think", name),
			txt("Then I forgor", "?"),
			txt("But then I goon", name, 5000),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (1):
			add_text_box(_goon_id, [
			txt("Watashi wa", name + "-chan"),
			txt("goon-chan desu", name + "-chan", 5000),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (2):
			add_text_box(_goon_id, [
			txt("I think,", "Des" + name + "cartes"),
			txt("Therefore I goon.", "Des" + name + "cartes", 5000),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (3):
			add_text_box(_goon_id, [
			txt("g", name, 1000),
			txt("o", name, 1000),
			txt("o", name, 1000),
			txt("n", name, 1000),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (4):
			add_text_box(_goon_id, [
			txt("Rise and goon.", "Alpha " + name),
			txt("BECAUSE WHOSE GONNA CARRY THE GOONS, SON?", "Alpha " + name),
			txt("I'm on that Groind.", "Alpha " + name, 5000),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (5):
			add_text_box(_goon_id, [
			txt("<div>" + name + "     <div>", name + "-tml"),
			txt("<div>        " + name + "<div>", name + "-tml"),
			txt("How do i center this", name + "-tml"),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (6):
			add_text_box(_goon_id, [
			txt("E equals", "Albert " + name),
			txt("Goon-c squared", "Albert " + name),
			txt("This is the pinnacle of science", "Albert " + name),
			txt("The theory of goontivity.", "Albert " + name),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (7):
			add_text_box(_goon_id, [
			txt(name, ""),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (8):
			add_text_box(_goon_id, [
			txt("Invest in GooCoin now", name + " bro"),
			txt("IT'S GOING TO THE GOOOOON", name + " bro"),
			txt("GOOCOIN GOOCOIN GOOCOIN GOOCOIN", name + " bro"),
			txt("oh it went to 0§§§§§§§§§§.§§§§§.§§§§§§.§§§§§§§well there goes my life savings", name + " bro"),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
			
			case (9):
			add_text_box(_goon_id, [
			txt("I think,", "Des" + name + "cartes"),
			txt("oh wait I don't", "Des" + name + "cartes...", 5000),
			txt("", "" , 0, turn_speaking_off)
			])
			break;
		}
		
	}
}