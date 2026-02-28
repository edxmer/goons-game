
level_text_scale=0.2+(5.25-(text_pulse_timer%5-2.5)*(text_pulse_timer%5-2.5))*0.006

text_pulse_timer+=delta_time/1000000
text_pulse_timer%=5





level=global.reward_level
if (!first_end_step) &&!global.loaded_from_save{
	
	if !second_happened{
		if !global.loaded_from_save
		{
			possible_items = workstation_get_all_possible_items()
			generate_objective_items()
			second_happened=true
		}
	}
}

if (previous_level == level-1) { 

switch (level) {


case 2: 
add_text_box_gui([

txtg("Yes, feed me, my little precious goons", "The Primordial Goo"),
txtg("I require much sustenance", "The Primordial Goo"),

]) 
break;

case 3: 
add_text_box_gui([

txtg("I am of goo", "The Primordial Goo"),
txtg("But goo is also of me", "The Primordial Goo"),

]) 
break;

case 4: 
add_text_box_gui([

txtg("goon goon goon", "goon"),
txtg("shut up goon", "The Primordial Goo"),

]) 
break;



case 5: 
add_text_box_gui([

txtg("My butt itches", "The Primordial Goo"),
txtg("goon?", "goon"),
txtg("Give me more stuff so i can use them to scratch my itch from the inside", "The Primordial Goo"),

]) 
break;

case 6: 
add_text_box_gui([

txtg("What's brown and sticky?", "The Primordial Goo"),
txtg("A stick", "The Primordial Goo"),
txtg("no, it's brown goon", "goon"),
txtg("shut up goon", "The Primordial Goo"),

]) 
break;

case 7: 
add_text_box_gui([

txtg("I need a better haircut", "The Primordial Goo"),
txtg("need more goon", "goon"),
txtg("shut up goon", "The Primordial Goo"),

]) 
break;

case 8: 
add_text_box_gui([

txtg("Dogs can't operate on MRI machines but cat scan", "The Primordial Goo"),
txtg("i can goon", "goon"),
txtg("Who would've thought, goon", "The Primordial Goo"),

]) 
break;

case 9: 
add_text_box_gui([

txtg("What rhymes with orange", "The Primordial Goo"),
txtg("no it doesn't", "goon"),
txtg("oh shut up goon", "The Primordial Goo"),

]) 
break;



case 10: 
add_text_box_gui([

txtg("What??? Cigarettes???", "The Primordial Goo"),
txtg("But I don't even smoke!", "The Primordial Goo"),
txtg("i goon", "goone"),

]) 
break;


case 11: 
add_text_box_gui([

txtg("Who's using this many cigarettes?????", "The Primordial Goo"),
txtg("I'll report them to the proper authorities for littering", "The Primordial Goo"),

]) 
break;


case 12: 
add_text_box_gui([

txtg("Cigarettes? More like lung cancer", "The Primordial Goo"),
txtg("Drink milk non-goo people, much better than cigarettes", "The Primordial Goo"),
txtg("It's good for your goon too.", "The Primordial Goo"),
txtg("GOOOOOOOOONNN", "goon"),

]) 
break;


case 13: 
add_text_box_gui([

txtg("FOOD FOOD FOOD", "The Primordial Goo"),

]) 
break;

case 14: 
add_text_box_gui([

txtg("YEAAAHHHHH", "The Primordial Goo"),
txtg("GOOOOOOON", "goon"),

]) 
break;


case 15: 
add_text_box_gui([

txtg("Spam is a canned precooked meat product made by the Hormel Foods Corporation, first introduced in 1937.", "The Primordial Goo"),
txtg("The labeled ingredients in the classic variety of Spam are chopped pork shoulder meat, with ham meat added, salt, water, modified potato starch as a binder, sugar, and sodium nitrite as a preservative.", "The Primordial Goo")

]) 
break;


case 16: 
add_text_box_gui([

txtg("A dyslexic man walks into a bra...", "The Primordial Goo"),
txtg("A dyslexic goon drinks some goon...", "goon"),
txtg("That doesn't even make sense, goon", "The Primordial Goo"),

]) 
break;

case 18: 
add_text_box_gui([

txtg("Who wants to learn roan numerals?", "The Primordial Goo"),
txtg("me!", "goon"),
txtg("that wasn't the joke goon", "The Primordial Goo"),
txtg("I would've said 'I for one', but you ruined it", "The Primordial Goo"),
txtg("ohhhh" , "goon"),
txtg("yeah, go back to gooning, little goon." , "The Primordial Goo"),

]) 
break;

case 20: 
add_text_box_gui([

txtg("i once tried noog", "The Primordial Goo"),
txtg("ordered it from shein", "The Primordial Goo"),
txtg("i almost died while consuming it", "The Primordial Goo"),
txtg("never again", "The Primordial Goo"),
txtg("i'll stay with my trusty goon", "The Primordial Goo"),
]) 
break;


case 22: 
add_text_box_gui([

txtg("When the mass of a goon gets big enough", "The Primordial Goo"),
txtg("It can bend the space-time with its goontivity", "The Primordial Goo"),
txtg("But if it reaches a goonmass so large that even goonlight can't escape", "The Primordial Goo"),
txtg("We call it a goonhole", "The Primordial Goo"),
txtg("And this point is its goongularity", "The Primordial Goo"),

]) 
break;

case 25: 
add_text_box_gui([

txtg("Yo", "Lil Primordial Goo"),
txtg("When the goon gets tasty everyday", "Lil Primordial Goo"),
txtg("I eat them up without disarray", "Lil Primordial Goo"),
txtg("In my stomach they can never decay", "Lil Primordial Goo"),
txtg("And thus I am here to stay", "Lil Primordial Goo"),
txtg("Lil primordial goo§§§§§§- §§§§§§§- §§§out", "The Primordial Goo"),

]) 
break;



case 30: 
add_text_box_gui([

txtg("Wow, level 30? Impressive", "The Primordial Goo"),
txtg("very goony", "goon"),
txtg("Reach level 100 to get a last secret message", "The Primordial Goo"),


]) 
break;

case 100: 
add_text_box_gui([

txtg("goon", "The Primordial Goo"),


]) 
break;


}
}



previous_level = level