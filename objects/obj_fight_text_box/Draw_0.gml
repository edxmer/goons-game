if global.movement_fucker!=0{
ticker++
if ticker%2=0{
print_text=append_char_from(text[bubble_number], print_text, print_text_id)
}
if bubble_number>=array_length(text){
instance_destroy()
}}

if name!=""{
	var length=string_length(name)/16*5.5+1
draw_sprite_ext(spr_blank_square_textbox_square,0,x-15*6-0.6,y-16,length+0.1,4.6,0,c_black,1)
draw_sprite_ext(spr_blank_square_textbox_square,0,x-15*6,y-16,length,4.5,0,#9F9F9F,1)
draw_set_color(c_black)
draw_set_font(textbox_fight_font_name)
draw_text(x-85,y-48,name)
}


draw_sprite_ext(spr_blank_square_textbox,0,x,y,12.1,4.6,0,c_black,1)
draw_sprite_ext(spr_blank_square_textbox,0,x,y,12,4.5,0,c_white,1)
draw_set_color(c_black)
draw_set_font(textbox_fight_font)
draw_text(x-76,y-30,print_text)
draw_set_color(c_white)