level=global.reward_level
if (!first_end_step) {
	
	if !second_happened{
		possible_items = workstation_get_all_possible_items()
		generate_objective_items()
		second_happened=true
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

case 7: 
add_text_box_gui([

txtg("I need a better haircut", "The Primordial Goo"),

]) 
break;

case 10: 
add_text_box_gui([

txtg("What??? Cigarettes???", "The Primordial Goo"),
txtg("But I don't even smoke!", "The Primordial Goo"),

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
txtg("Drink milk guys, much better than cigarettes", "The Primordial Goo"),
txtg("It's good for your goon too.", "The Primordial Goo"),

]) 
break;


}
}



previous_level = level