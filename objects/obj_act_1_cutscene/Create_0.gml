draw_bg = true
bg_color = c_black


// spr_primordial_goo
show_primordial_goo=false
pgoo_alpha = 0
counter = 0
goo_fade_back = false

// spr_goon
show_goon=false
goon_alpha = 0

play_goon_sound = function(){
	sound_play_category_at("murr",0,0)
}


var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()

add_text_box_gui([
	txtg("At first, there was nothing.\n\n\n\n(Left click to continue)", "???"),
	
	txtg("Then, there was something-", "???", method(self, function(){
		show_primordial_goo = true
	})),
	txtg("The Primordial Goo", "???"),
	txtg("The Goo is eternal", "???"),
	txtg("The Goo is everything", "???"),
	txtg("We were but ripples on its divine surface", "???"),
	txtg("The Goo knew no flaw", "???", method(self, function(){
		goo_fade_back = true
		show_goon = true
		play_goon_sound()
	})),
	
	txtg("Then, the goons appeared", "???"),
	txtg("The goons knew flaw", "???", play_goon_sound),
	txtg("goon", "goon", play_goon_sound),
	txtg("goon", "goon", play_goon_sound),
	txtg("*goons*", "goon"),
	txtg("Yeah, they like to say that a lot", "???", play_goon_sound),
	txtg("goon", "goon", play_goon_sound),
	txtg("goon", "goon", play_goon_sound),
	txtg("goon", "goon", play_goon_sound),
	txtg("goon goon goon", "goon"),
	txtg("Stop, or I'll tear apart your miserable soul", "???", play_goon_sound),
	txtg("goon?", "goon"),
	txtg("And take away your goon", "???", play_goon_sound),
	txtg("*shivers*", "goon"),
	txtg("Good.", "???"),
	txtg("In the divine realm of Winter, their only purpose is to bring gifts to their master, The Primordial Goo.", "???"),
	txtg("You are the soul chosen as their coordinator.", "???"),
	txtg("You'll be helping them fulfill their divine duty.", "???"),
	txtg("But be aware of their limited intellectual capabilities.", "???", play_goon_sound),
	txtg("gooon????", "goon"),
	txtg("Good luck", "???", method(self, function(){
		room_goto(Room1)
	})),
])